class Subcategory < ActiveRecord::Base
	paginates_per 2
	has_one :product
	belongs_to :category
	validates_presence_of :category_id,:sub_category
	
end
