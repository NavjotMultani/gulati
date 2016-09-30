class CreateMaincategories < ActiveRecord::Migration
  def change
    create_table :maincategories do |t|
    	t.string "main_category",:limit=>25
    	t.boolean "is_active",:default=>true
    	t.integer "created_by"
    	t.integer "updated_by"
      t.timestamps null: false
    end
  end
end
