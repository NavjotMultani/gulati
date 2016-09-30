class CreateUserdetails < ActiveRecord::Migration
  def change
    create_table :userdetails do |t|
    	t.integer "user_id"
    	t.string "name",:limit=>25
    	t.string "address",:limit=>50
    	t.string "pincode",:limit=>10
    	t.string "phone",:limit=>25
    	t.string "profile_pic",:limit=>25
       	t.integer "created_by"
    	t.integer "updated_by"
      t.timestamps null: false
    end
  end
end
