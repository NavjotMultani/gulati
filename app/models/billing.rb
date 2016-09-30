class Billing < ActiveRecord::Base
	validates_presence_of :order_id,:name,:address,:pincode,:phone
	has_one :Orderdetails
end
