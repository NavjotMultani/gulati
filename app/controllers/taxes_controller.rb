class TaxesController < ApplicationController
   layout 'admin'
  before_filter :confirm_logged_in_as_admin
  def taxes
    @page_title = "Tax Details" 
  end

  def addTax
    @tax = Tax.new(main_params)
  	if @tax.valid?
  		@tax.save
      @id = @tax.id
      @msg = "Tax Saved Successfully"
  		render 'taxes'
  	else
  		@object = @tax.errors.full_messages
  		render 'taxes'
  	end
  end

  def show
    @page_title = "Tax Details" 
  	@tax = Tax.all
  end

  def edit
    @page_title = "Tax Details"
    @tax = Tax.find(params[:id]) 
    if @tax
      render 'edit'
    else
      redirect_to :action=>"show"
    end
  end

  def updateTax
  	@tax=Tax.find(params[:id])
      if @tax.valid?
        @tax.update_attributes(main_params)
        redirect_to :action=> 'show'
      else
        @object=@tax.errors.full_messages
       render 'edit' 
      end
  end
  # def delete
  #   @id = params[:id]
  #   @tax = Tax.find_by_id(@id)
  #   if @tax.destroy
  #     redirect_to :action=>'show'
  #   else
  #     render 'error'
  #   end
  # end

  def main_params
  	return params.require(:tax).permit(:tax,:created_by,:updated_by)
  end
end
