class ProductsController < ApplicationController
    layout 'admin'
   include ApplicationHelper
   before_filter :confirm_logged_in_as_admin
  def products
    @page_title = "Product Details"
    @subcategories = Subcategory.all
  end
  def addProduct
    products
    photo1 = upload(params[:product][:photo1])
    photo2 = upload(params[:product][:photo2])
  params[:product][:photo1]=photo1
  params[:product][:photo2]=photo2
    @products = Product.new(product_params)
          if @products.valid?
              @products.save
              @msg = "Product Saved Successfully"
              redirect_to :action=>'show'
          else
              @object = @products.errors.full_messages
              render 'products'
          end   
    end
    def product_params
     return params.require(:product).permit(:user_id,:subcategory_id,:product_name,:product_code,:price,:color,:size,:material,:photo1,:photo2,:created_by,:updated_by,:handling_charges)
    end
  def show
    products 
    @product = Product.order(product_name: :desc).page params[:page]
    if params.has_key?(:search)
      name = params[:search][:name]
      if session[:is_admin]
        @product = Product.where("product_name LIKE '%#{name}%'")
      else
      redirect_to :controller=>'admin',:action=>'error_msg' 
      end
    end
  end
  def view 
    @id = params[:id]
    @product = Product.find_by_id(@id)
    if @product
      render 'view'
    else
    redirect_to :action=>'show' 
    end
  end
  def edit 
    products
    if params[:id]
    @product = Product.find(params[:id]) 
      else
    redirect_to :action=>"show"
      end
  end

  def updateProduct
      products
      photo1 = (params[:product][:photo1] ? upload(params[:product][:photo1]) : params[:product][:photo11] )
      photo2 = (params[:product][:photo2] ? upload(params[:product][:photo2]) : params[:product][:photo22] )
      if photo1 && photo2  
      params[:product][:photo1]=photo1
      params[:product][:photo2]=photo2
      @product=Product.all
        @products = Product.find(params[:id])
        if @products.valid?
          @products.update_attributes(product_params)
          redirect_to :action => 'show'
        else
          @object = @products.errors.full_messages
          render 'edit'
        end
       end
  end
  def orderhistory
    @orderhistory =Ordermaster.all
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
  def updateOrdermaster
    vieworder
    @ordermaster=Ordermaster.all
    @ordermaster = Ordermaster.find(params[:id])
      @ordermaster.status = params[:status]
        if @ordermaster.valid?
          @ordermaster.update_attributes(orderParams)
          redirect_to :action => 'orderhistory'
        else
          @object = @ordermaster.errors.full_messages
          render 'vieworder'
        end
      
  end
  def orderParams
    return params.require(:ordermaster).permit(:status)
  end


end
