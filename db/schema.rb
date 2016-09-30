# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160819045558) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "billings", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "name",       limit: 20
    t.string   "address",    limit: 10
    t.string   "pincode",    limit: 20
    t.string   "phone",      limit: 20
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "categories", force: :cascade do |t|
    t.integer  "maincategory_id"
    t.string   "category",        limit: 25
    t.boolean  "is_active",                  default: true
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "maincategories", force: :cascade do |t|
    t.string   "main_category", limit: 25
    t.boolean  "is_active",                default: true
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "orderdetails", force: :cascade do |t|
    t.integer  "ordermaster_id"
    t.integer  "product_id"
    t.decimal  "cost",           precision: 10, scale: 2
    t.decimal  "row_total",      precision: 10, scale: 2
    t.integer  "quantity"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "ordermasters", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "total_products"
    t.decimal  "total_cost",     precision: 10, scale: 2
    t.string   "mop"
    t.string   "status"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.decimal  "total_tax",      precision: 10, scale: 2
  end

  create_table "products", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "subcategory_id"
    t.string   "product_name",     limit: 25
    t.string   "product_code",     limit: 30
    t.string   "color",            limit: 30
    t.string   "size",             limit: 30
    t.string   "material",         limit: 50
    t.decimal  "handling_charges",            precision: 10, scale: 2
    t.decimal  "price",                       precision: 10, scale: 2
    t.string   "photo1"
    t.string   "photo2"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
  end

  create_table "shippings", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "name",       limit: 20
    t.string   "address",    limit: 10
    t.string   "pincode",    limit: 20
    t.string   "phone",      limit: 20
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "subcategories", force: :cascade do |t|
    t.integer  "category_id"
    t.string   "sub_category"
    t.boolean  "is_active",    default: true
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "taxes", force: :cascade do |t|
    t.decimal  "tax",        precision: 10, scale: 2
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "userdetails", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",        limit: 25
    t.string   "address",     limit: 50
    t.string   "pincode",     limit: 10
    t.string   "phone",       limit: 25
    t.string   "profile_pic", limit: 25
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",      limit: 25
    t.string   "password",   limit: 50
    t.boolean  "is_active",             default: true
    t.boolean  "is_admin",              default: false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

end
