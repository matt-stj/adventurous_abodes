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

ActiveRecord::Schema.define(version: 20151201234811) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ordered_trips", force: :cascade do |t|
    t.integer  "travellers"
    t.integer  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "order_id"
    t.integer  "rental_id"
  end

  add_index "ordered_trips", ["order_id"], name: "index_ordered_trips_on_order_id", using: :btree
  add_index "ordered_trips", ["rental_id"], name: "index_ordered_trips_on_rental_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "status",     default: "Pending"
    t.integer  "total"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "rental_types", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rentals", force: :cascade do |t|
    t.text     "name"
    t.text     "description"
    t.integer  "price"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "rental_type_id"
    t.text     "status",             default: "active"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image"
    t.integer  "user_id"
  end

  add_index "rentals", ["rental_type_id"], name: "index_rentals_on_rental_type_id", using: :btree
  add_index "rentals", ["user_id"], name: "index_rentals_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "role",            default: 0
  end

  add_foreign_key "ordered_trips", "orders"
  add_foreign_key "ordered_trips", "rentals"
  add_foreign_key "orders", "users"
  add_foreign_key "rentals", "rental_types"
  add_foreign_key "rentals", "users"
end
