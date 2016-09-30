module ApplicationHelper
	@@types = ['png','jpeg','jpg','gif','PNG','JPEG','JPG','GIF']
	def checkImage(type)
		return true if @@types.include?(type)
	end
	def upload(file)
		upload_io = file
		filename = file.original_filename
		type =filename.split('.').last
		if checkImage(type)
			fld = Time.now.to_i
			rd = rand(2**256).to_s(36)[0..7]
			filename = "img#{fld}#{rd}." + type
			File.open(Rails.root.join("public","uploads",filename),"wb") do |file|
				file.write(upload_io.read)
				return filename
			end
		else
			return false
		end
	end
	def public
    @maincategory = Maincategory.all
    @category = Category.all
    @subcategory = Subcategory.all
    @products = Product.all
    @details = Userdetail.find_by_user_id(session[:user_id])
  end
  def cart
    @cart = []
    @qty = {}
    @hc = 0
    @tax = 0
    if !session[:products].nil?
      session[:products].each do |p,qty|
        id = p
        @qty.merge!({p => qty})
        @cart << Product.find(id)
      end
      updateCartCount
    end
  end
  def updateCartCount
    session[:cart_size] = session[:products].size
  end
def bootstrap_class_for(flash_type)
    case flash_type
      when :success
        "alert-success" # Green
      when :error
        "alert-danger" # Red
      when :alert
        "alert-warning" # Yellow
      when :notice
        "alert-info" # Blue
      else
        flash_type.to_s
    end
  end
  
end
