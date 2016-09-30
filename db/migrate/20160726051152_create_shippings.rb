class CreateShippings < ActiveRecord::Migration
  def change
    create_table :shippings do |t|
    	t.integer "order_id"
    	t.string "name",:limit=>20
    	t.string "address",:limit=>10
    	t.string "pincode",:limit=>20
    	t.string "phone",:limit=>20
    	t.integer "created_by"
    	t.integer "updated_by"
      t.timestamps null: false
    end
  end
end
