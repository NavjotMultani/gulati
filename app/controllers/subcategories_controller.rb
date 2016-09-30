class SubcategoriesController < ApplicationController
  layout 'admin'
include ApplicationHelper
before_filter :confirm_logged_in_as_admin
  def subcategories
    @page_title = "Sub Category Details" 
    if params[:id]
       @id = params[:id]
        @category = Category.where("id = #{@id}")
    else
        @category = Category.all
    end
  end
  def addSubcategory
   
    @category = Category.all
  	@subcategory = Subcategory.new(main_params)
  	if @subcategory.valid?
  		@subcategory.save
   		redirect_to :controller=>'products',:action=>'products'
  	else
  		@object = @subcategory.errors.full_messages
  		render 'subcategories'
  	end
  end

  def show
    @page_title = "Sub Category Details" 
    @category = Category.all
  	@subcategory = Subcategory.all
    @subcategory = Subcategory.order(sub_category: :desc).page params[:page]
  end

  def edit 
    @page_title = "Sub Category Details" 
    @category = Category.all
    @subcategory = Subcategory.find(params[:id]) 
    if @subcategory
      render 'edit'
  else
    redirect_to :action=>"show"
  end
  end

  def updateSubcategory
  	@subcategory=Subcategory.find(params[:id])
    if @subcategory.valid?
      @subcategory.update_attributes(main_params)
      redirect_to :action=> 'show'
    else
      @object=@subcategory.errors.full_messages
     render 'edit'
      
    end
  end
  # def delete
  #   @id = params[:id]
  #   @subcategory = Subcategory.find_by_id(@id)
  #   if @subcategory.destroy
  #     redirect_to :action=>'show'
  #   else
  #     render 'error'
  #   end
  # end

  def main_params
  	return params.require(:subcategory).permit(:category_id,:sub_category,:is_active,:created_by,:updated_by)
  end
end
