class CreateSubcategories < ActiveRecord::Migration
  def change
    create_table :subcategories do |t|
    	t.integer "category_id"
    	t.string "sub_category"
    	t.boolean "is_active",:default=>true
    	t.integer "created_by"
    	t.integer "updated_by"
      t.timestamps null: false
    end
  end
end
