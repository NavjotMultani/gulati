class User < ActiveRecord::Base
	require 'digest/sha1'
	before_save :do_hashing
	has_one :Userdetail
	validates_presence_of :email,:password
	validates_uniqueness_of :email
	paginates_per 2
	VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
	validates_length_of :password, minimum: 6 
	def do_hashing
		self.password = hash_password(self.password)
	end
	def hash_password(password)
	return Digest::SHA1.hexdigest(password)
	end
	 def self.authenticate_user(email,password)
    	@user = User.find_by_email(email)
		if @user && @user.password ==  self.new.hash_password(password)
			return @user
		else
			return false
	  	end 
    end
end
