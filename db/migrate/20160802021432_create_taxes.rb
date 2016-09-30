class CreateTaxes < ActiveRecord::Migration
  def change
    create_table :taxes do |t|
    	t.decimal "tax", :precision=>10,:scale=>2
    	t.integer "created_by"
    	t.integer "updated_by"
      t.timestamps null: false
    end
  end
end
