class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
    	t.integer "maincategory_id"
    	t.string "category",:limit=>25
    	t.boolean "is_active",:default=>true
    	t.integer "created_by"
    	t.integer "updated_by"
      t.timestamps null: false
    end
  end
end
