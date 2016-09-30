class MaincategoriesController < ApplicationController
  layout 'admin'
  before_filter :confirm_logged_in_as_admin
  def maincategories
    @page_title = "Main Category Details" 
  end

  def addMainCategory
    @mc = Maincategory.new(main_params)
  	if @mc.valid?
  		@mc.save
      @id = @mc.id
  		redirect_to :controller=>'categories',:action=>'categories',:id=>@id
  	else
  		@object = @mc.errors.full_messages
  		render 'maincategories'
  	end
  end

  def show
    @page_title = "Maincategory Details" 
  	@mains = Maincategory.all
    @mains = Maincategory.order(main_category: :desc).page params[:page]
  end

  def edit
    @page_title = "Maincategory Details"
    @maincategory = Maincategory.find(params[:id]) 
    if @maincategory
      render 'edit'
    else
      redirect_to :action=>"show"
    end
  end

  def updateMainCategory
  	@maincategory=Maincategory.find(params[:id])
      if @maincategory.valid?
        @maincategory.update_attributes(main_params)
        redirect_to :action=> 'show'
      else
        @object=@maincategory.errors.full_messages
       render 'edit' 
      end
  end
  # def delete
  #   @id = params[:id]
  #   @maincategory = Maincategory.find_by_id(@id)
  #   if @maincategory.destroy
  #     redirect_to :action=>'show'
  #   else
  #     render 'error'
  #   end
  # end

  def main_params
  	return params.require(:maincategory).permit(:main_category,:is_active,:created_by,:updated_by)
  end
end
