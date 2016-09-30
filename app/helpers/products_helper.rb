module ProductsHelper

	def apply_color(nm)
		case nm
		when "Being Prepared"
			return "prepared"
		when "On Hold"
			return "onhold"
		when "Received"
			return "received"
		when "Cancelled"
			return "cancel"
		end
	end

end
