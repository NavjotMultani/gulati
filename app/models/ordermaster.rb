class Ordermaster < ActiveRecord::Base
	belongs_to :Orderdetail
	has_many :product
	has_one :User
	validates_presence_of :mop
	validates_presence_of :total_products,:total_cost,:mop
	
end
