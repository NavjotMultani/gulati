class CreateOrdermasters < ActiveRecord::Migration
  def change
    create_table :ordermasters do |t|
    	t.integer "user_id"
    	t.integer "total_products"
      t.decimal "total_cost", :precision=>10,:scale=>2
		  t.decimal "total_tax", :precision=>10,:scale=>2
        t.string "mop"
        t.string "status"
        t.integer "created_by"
    	t.integer "updated_by"
      t.timestamps null: false
    end
  end
end
