# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_01_26_205124) do

  create_table "discount_product_type_groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "discount_id"
    t.integer "required_quantity"
    t.integer "max_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "group_type"
  end

  create_table "discount_product_types", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "product_type_id"
    t.integer "discount_product_type_group_id"
    t.index ["discount_product_type_group_id"], name: "index_discount_product_types_group_id"
    t.index ["product_type_id"], name: "index_discount_product_types_on_product_type_id"
  end

  create_table "discounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.json "json"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_checked"
    t.decimal "price", precision: 10, scale: 2
    t.boolean "removed", default: false
    t.bigint "store_id"
    t.string "image_url"
    t.index ["store_id"], name: "index_discounts_on_store_id"
  end

  create_table "product_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stores", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "code"
    t.string "city"
    t.string "address"
    t.json "json"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
