class UserdetailsController < ApplicationController
  layout 'admin'
  include ApplicationHelper
  before_filter :confirm_logged_in_as_admin
  def userdetails
    @page_title = "User Details" 
    @users = User.all
    
  end
    def addUser
  	userdetails
      if params[:userdetail][:profile_pic]
        photo = upload(params[:userdetail][:profile_pic])
        params[:userdetail][:profile_pic]=photo
      end
        @detail = Userdetail.new(user_params)
           if @detail.valid?
             @detail.save
              @msg = "User Saved Successfully"
              redirect_to :action=>'show'
           else
              @object = @detail.errors.full_messages
              render 'userdetails'
           end    
    end
    def user_params
     return params.require(:userdetail).permit(:user_id,:name ,:address,:pincode,:phone,:profile_pic,:created_by,:updated_by)
    end
    def show
    	userdetails
      @users = User.order(email: :desc).page params[:page]
    end
    def edit      
    	@userdetail =Userdetail.all
      @id = params[:id]
      @userdetail = Userdetail.find_by_user_id(@id)
      if @userdetail
        render 'edit'
      else
      redirect_to :action=>'show' 
      end
    end
    def view
    	@userdetail =Userdetail.all
    	@id = params[:id]
	    @userdetail = Userdetail.find_by_user_id(@id)
	    if @userdetail
	      render 'view'
	    else
	    redirect_to :action=>'show' 
	    end
    end
    def updateUser
      profile_pic = (params[:userdetail][:profile_pic] ? upload(params[:userdetail][:profile_pic]) : params[:userdetail][:profile] )
       if profile_pic
        params[:userdetail][:profile_pic]=profile_pic
      	@userdetail = Userdetail.find(params[:id])
	      if @userdetail.valid?
	        @userdetail.update_attributes(user_params)
	        redirect_to :action => 'show'
	      else
	        @object = @userdetail.errors.full_messages
	        render 'edit'
	      end
	    end
    end
end
