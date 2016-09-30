class Maincategory < ActiveRecord::Base
	paginates_per 1
	has_many :category
	validates_presence_of :main_category
	validates_uniqueness_of :main_category
end
