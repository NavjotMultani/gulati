class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :success, :warning ,:danger, :info,:alert
 def confirm_logged_in
      if session[:email]
        return true
      else
        redirect_to :controller=>'public',:action=>'login'
        return false
      end
end
def confirm_logged_in_as_public
    if confirm_logged_in
      if session[:user_type] == "public"
        return true
      else
        redirect_to :controller=>'public'
        return false  
      end
    else
      redirect_to :controller=>'public'
      return false
    end
  end
  def confirm_logged_in_as_admin
    if confirm_logged_in
      if session[:user_type] && session[:user_type] == "admin"
        return true
      else
        redirect_to :controller=>'public'
        return false
      end
    else
      
      return false
    end
  end
def logout
    reset_session
    redirect_to :controller=>'public',:action=>'public'
end
def dp
  if session[:email]
    @uid = session[:user_id]
    @details = Userdetail.find_by_user_id(@uid)
  else
    redirect_to :controller=>'login',:action=>'login'
  end
end
def clearCart
  session[:products]=nil
  session[:cart_size]=nil
  session[:totalCost]=nil
  session[:total_tax]=nil
  session[:finalCost]=nil
  session[:status] = nil
end
end
