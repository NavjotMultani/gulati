class AdminController < ApplicationController
	layout 'admin'
	before_filter :confirm_logged_in_as_admin
	include ApplicationHelper
  def admin
  	session[:count_user] = User.count('email', :distinct => true)
    session[:count_email] = User.count('email' ,:distinct=>true )
    session[:count_order] =Ordermaster.count('id',:distinct=>true)
    @tax = Tax.all
    if Ordermaster.exists?
    @cancel = Ordermaster.where("status ='Cancelled'").count
    @pending = Ordermaster.where("status ='On Hold' OR status='Being Prepared'").count
    end
  end
  def error_msg 
  end
  
end
