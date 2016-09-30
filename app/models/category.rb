class Category < ActiveRecord::Base
	paginates_per 2
	belongs_to :maincategory
	has_many :subcategory
	validates_presence_of :maincategory_id
	validates_presence_of :category,:message =>" Name can't be blank"
end
