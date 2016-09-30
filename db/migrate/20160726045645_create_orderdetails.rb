class CreateOrderdetails < ActiveRecord::Migration
  def change
    create_table :orderdetails do |t|
    	t.integer "ordermaster_id"
    	t.integer "product_id"
    	t.decimal "cost", :precision=>10,:scale=>2
    	t.decimal "row_total",:precision=>10,:scale=>2
    	t.integer "quantity"
      t.integer "created_by"
    	t.integer "updated_by"
      t.timestamps null: false
    end
  end
end
