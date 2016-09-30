class CategoriesController < ApplicationController
  layout 'admin'
  before_filter :confirm_logged_in_as_admin
  include ApplicationHelper
  def categories
    
    @page_title = "Category Details"
    if params[:id]
      @id = params[:id]
      @main = Maincategory.where("id = #{@id}")
    else
      @main = Maincategory.all
    end
  end

  def addCategory
    @page_title = "Category Details"
    @main = Maincategory.all
  	@category = Category.new(main_params)
  	if @category.valid?
  		@category.save
      @id = @category.id
  		@msg = "Saved Succesfully"
  		redirect_to :controller=>'subcategories',:action=>'subcategories',:id =>@id
  	else
  		@object = @category.errors.full_messages
  		render 'category'
  	end
  end

  def show
    @page_title = "Category Details"
  	@category = Category.all
    @category = Category.order(category: :desc).page params[:page]
  end

  def edit
    @page_title = "Category Details"
    @main = Maincategory.all
    @category = Category.find(params[:id]) 
    if @category
      render 'edit'
    else
      redirect_to :action=>"show"
    end
  end

  def updateCategory
  	@category=Category.find(params[:id])
    if @category.valid?
      @category.update_attributes(main_params)
      redirect_to :action=> 'show'
    else
      @object=@category.errors.full_messages
      render 'edit'
      
    end
  end

  # def delete
  #   @id = params[:id]
  #   @category = Category.find_by_id(@id)
  #   if @category.destroy
  #     redirect_to :action=>'show'
  #   else
  #     render 'error'
  #   end
  # end

  def view
    @page_title = "Category Details"
    @id = params[:id]
    @category = Category.find_by_id(@id)
    if @category
      render 'view'
    else
    redirect_to :action=>'show' 
    end
  end
  
  def main_params
  	return params.require(:category).permit(:maincategory_id,:category,:is_active,:created_by,:updated_by)
  end
end
