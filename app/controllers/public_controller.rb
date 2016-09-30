class PublicController < ApplicationController
  layout 'public'
  include ApplicationHelper
  before_filter :cart
  before_filter :public
  def login
     @page_title ="Login"
     if params[:msg]
      @msg = params[:msg]
    end
  end
  def signup
    @page_title ="Signup"
  end
  def addUserdetail
      if params[:userdetail][:profile_pic]
        photo = upload(params[:userdetail][:profile_pic])
        params[:userdetail][:profile_pic]=photo
      end
        @detail = Userdetail.new(userdetail_params)
           if @detail.valid?
             @detail.save
              @msg = "User Details Saved Successfully"
              render 'personaldetails'
           else
              @object = @detail.errors.full_messages
              render 'personaldetails'
           end    
    end
    def userdetail_params
     return params.require(:userdetail).permit(:user_id,:name ,:address,:pincode,:phone,:profile_pic,:created_by,:updated_by)
    end
 def editpdetail      
      @userdetail =Userdetail.all
      @id = params[:id]
      @userdetail = Userdetail.find_by_id(@id)
      if @userdetail
        render 'editpdetail'
      else
      redirect_to :action=>'personaldetails' 
      end
  end
  def updateUserdetail
      profile_pic = (params[:userdetail][:profile_pic] ? upload(params[:userdetail][:profile_pic]) : params[:userdetail][:profile] )
       if profile_pic
        params[:userdetail][:profile_pic]=profile_pic
        @userdetail = Userdetail.find(params[:id])
        if @userdetail.valid?
          @userdetail.update_attributes(userdetail_params)
          @msg = "Saved"
          redirect_to :action=>'editpdetail',:id=>@userdetail.id
        else
          @object = @userdetail.errors.full_messages
          render 'editpdetail'
        end
      end
    end
  def authenticate
    email = params[:user][:email]
    password = params[:user][:password]
        @user = User.authenticate_user(email,password)
        if @user
              session[:user_id]= @user.id
              session[:is_admin]= @user.is_admin
              session[:email]= @user.email
              session[:user_type]= @user.is_admin == true ? "admin" : "public";
                 if session[:user_type]== "admin"
                    redirect_to :controller=>'admin' 
                  else
                    redirect_to :controller=>'public'
                  end
        else
             @msg = "Invalid Data....Please check your inputs...."
             render 'login'
        end
  end
  def addUser
    @insert=User.new(user_params)
    if @insert.valid?
      @insert.save
      @msg = "User successfully added"
      redirect_to :controller=>'public',:action=>'login',:msg=>"User successfully added....Now you can login",:method=>'post'
    else
      @object = @insert.errors.full_messages
      render 'signup'
    end
  end
  def user_params
    return params.require(:user).permit(:email,:password,:is_active,:is_admin)
  end
  def searchProducts
    @page_title ="Products"
    if params[:id]
       @id = params[:id]
       @products = Product.where("subcategory_id=#{@id}")
    end
  end
  def info
    @page_title ="Details"
    @product_id =params[:id]
    @products = Product.find_by_id(@product_id)
    if @products
    keys_blacklist = %W(id photo1 photo2 subcategory_id color product_id user_id created_by updated_by created_at updated_at )
    @feature_showlist = @products.attributes.except(*keys_blacklist)
    if !session[:products].nil?
        session[:products].each do |p,qty|
        id = p 
        if id == params[:id]
          @value = "1"
          break
        end
        end 
    end
    end
  end
  def cartview
    @page_title = "Cart"
    @tax =Tax.all
  end
def search
      @text = params[:search]
      @text = @text.downcase
      @products=Product.where("product_name LIKE '%#{@text}%' ")
        if @products 
          render 'searchProducts'
          if @products != @text
            flash[:alert] = "Product not found"
          end
        else  
          redirect_to :action=>'public'
        end
    
  end
  def slide
    render :partial => 'slide' , :layout => false
  end
  def orderhistory
    if session[:user_id]
      @orderhistory =Ordermaster.where("user_id=#{session[:user_id]}")
    else
      redirect_to :controller=>'admin',:action=>'error_msg' 
    end
  end
  def vieworder    
    if params[:id]
      @order_id = params[:id]
      @om = Ordermaster.where("id=#{@order_id}")
      @orderdetail = Orderdetail.where("ordermaster_id=#{@order_id}")
      @shipping = Shipping.where("order_id=#{@order_id}")
      @billing = Billing.where("order_id=#{@order_id}")
      @tax=Tax.all
     end
  end
  def addCart
    if params.has_key?(:cart)
      product_id =  params[:cart][:product_id]
      qty = params[:cart][:qty]
      hash = {product_id=>qty}
      session[:products] = session[:products] ? session[:products].merge!(hash) : hash
    end
    redirect_to :action=>'cartview'
  end
  def checkout
    cartview
    if !session[:user_id]
      flash[:alert]="Please check, you are logged in,if not Please firstly fill  your login form......"
       render 'public/login'
       return false
     else
      return true
    end
  end
  def saveOrder
    @om = Ordermaster.new()
    @om.user_id = session[:user_id]
    @om.total_tax = session[:total_tax]
    totalQty = 0
    totalCost = 0
    session[:products].each do |pid,qty|
      totalQty+= qty.to_f
      p = Product.find(pid)
      totalCost+= qty.to_f * p.price.to_f
      totalCost=session[:finalTotal]
    end
    @om.total_products = totalQty
    @om.total_cost = totalCost
    @om.mop = params[:mop]
    @om.status = "Being Prepared"
    if @om.save
      @order_id = @om.id
      saveOrderDetail
      saveBilling
      saveShipping
      clearCart
      @msg ="Your order successfully placed......"
       render 'public/cartview'
     else
      @object=@om.errors.full_messages
      render 'public/checkout'
    end
  end
 
  def saveOrderDetail    
    session[:products].each do |pid,qty|
      @od = Orderdetail.new()
      p = Product.find(pid)
      @od.ordermaster_id = @order_id
      @od.product_id = pid
      @od.cost = p.price
       @od.quantity = qty
      @od.row_total = qty.to_f * p.price.to_f
      @od.save
    end
    return true
  end

  def saveShipping
    @shipping = Shipping.new()
    @shipping.order_id = @order_id
    @shipping.name =  (params[:sname].present? ? params[:sname] : params[:bname])
    @shipping.address = (params[:saddress].present? ? params[:saddress] : params[:baddress])
    @shipping.pincode = (params[:spincode].present? ? params[:spincode] : params[:bpincode])
    @shipping.phone = (params[:sphone].present? ? params[:sphone] : params[:bphone])
    @shipping.save
  
  end
  def saveBilling
    @billing = Billing.new()
    @billing.order_id = @order_id
    @billing.name = params[:bname]
    @billing.address = params[:baddress]
    @billing.pincode = params[:bpincode]
    @billing.phone = params[:bphone]
    @billing.save
  end
  def deleteCart
    if params[:id]
      session[:products].delete(params[:id])
      updateCartCount
      redirect_to :controller=>"public",:action=>"cartview"
    end
  end
  def updateCart
    if params[:id]
      if session[:products]
        qty = params[:quantity]
        session[:products][params[:id]] = qty
      else
        redirect_to :action=>'cartview'
      end
    end
  end
end
