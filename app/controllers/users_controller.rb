class UsersController < ApplicationController
  layout 'admin'
  before_filter :confirm_logged_in_as_admin
  include ApplicationHelper
  def users   
   @page_title ="User"
  end
  def addUser
    users
   @user = User.new(user_params)
    if @user.valid?
        @user.save
        @id = @user.id
        @msg = "User Saved Successfully"
        redirect_to :controller=>'userdetails',:action=>'userdetails',:id=>@id
        
      else
       	@object = @user.errors.full_messages
        render 'users' 
  	end
  end

  def show
    users
   	@users = User.order(email: :desc).page params[:page]
   end

    def edit
    users   
      if params[:id]
        @user = User.find(params[:id])
      else
        redirect_to :action => 'show'
      end
    end

    def update
      users
      @user = User.find(params[:id])
      if @user.valid?
        @user.update_attributes(user_params)
        redirect_to :action => 'edit'
      else
        @object = @user.errors.full_messages
        render 'edit'
      end
    end
    def user_params
     return params.require(:user).permit(:email,:password ,:is_admin,:is_active,:created_by,:updated_by)
    end
end
