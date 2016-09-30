class Userdetail < ActiveRecord::Base
	paginates_per 2
	belongs_to :user
	validates_presence_of :user_id,:name,:address,:pincode,:phone,:profile_pic
	validates_uniqueness_of :user_id

end
