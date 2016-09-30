class Orderdetail < ActiveRecord::Base
	belongs_to :Shipping
	belongs_to :Billing
	has_many :Ordermaster
	belongs_to :product
	validates_presence_of :ordermaster_id,:product_id,:cost,:row_total,:quantity
end
