class Product < ActiveRecord::Base
	belongs_to :subcategory
	paginates_per 2
	validates_presence_of :user_id,:subcategory_id,:product_name,:product_code,:color,:size,:material,:price,:photo1,:photo2
	validates_uniqueness_of :product_code
	before_save :downcase_field
	def downcase_field
		self.product_name.downcase!
	end
end
