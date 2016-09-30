class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string "email",:limit=>25
    	t.string "password",:limit=>50
    	t.boolean "is_active",:default=>true
    	t.boolean "is_admin",:default=>false
    	t.integer "created_by"
    	t.integer "updated_by"
      t.timestamps null: false
    end
  end
end
