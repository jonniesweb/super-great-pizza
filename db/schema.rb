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

ActiveRecord::Schema.define(version: 2018_10_03_014427) do

  create_table "discounts", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.json "json"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_checked"
    t.integer "location"
    t.decimal "price", precision: 10, scale: 2
    t.boolean "removed", default: false
  end

  create_table "discounts_product_types", id: false, force: :cascade do |t|
    t.integer "discount_id"
    t.integer "product_type_id"
    t.index ["discount_id"], name: "index_discounts_product_types_on_discount_id"
    t.index ["product_type_id"], name: "index_discounts_product_types_on_product_type_id"
  end

  create_table "product_types", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
