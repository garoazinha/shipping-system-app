# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_10_12_212621) do
  create_table "delivery_times", force: :cascade do |t|
    t.integer "min_distance"
    t.integer "max_distance"
    t.integer "estimated_delivery_time"
    t.integer "shipping_mode_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shipping_mode_id"], name: "index_delivery_times_on_shipping_mode_id"
  end

  create_table "distance_based_fees", force: :cascade do |t|
    t.integer "min_distance"
    t.integer "max_distance"
    t.decimal "fee"
    t.integer "shipping_mode_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shipping_mode_id"], name: "index_distance_based_fees_on_shipping_mode_id"
  end

  create_table "full_addresses", force: :cascade do |t|
    t.integer "service_order_id", null: false
    t.string "zip_code"
    t.string "city"
    t.string "state"
    t.string "address"
    t.integer "belonging_to", default: 5
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_order_id"], name: "index_full_addresses_on_service_order_id"
  end

  create_table "service_orders", force: :cascade do |t|
    t.string "product_code"
    t.integer "product_width"
    t.integer "product_height"
    t.integer "product_depth"
    t.integer "product_weight"
    t.string "recipient_name"
    t.string "recipient_registration_number"
    t.integer "distance"
    t.integer "status", default: 4
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
  end

  create_table "shipping_modes", force: :cascade do |t|
    t.string "name"
    t.integer "min_distance"
    t.integer "max_distance"
    t.integer "min_weight"
    t.integer "max_weight"
    t.decimal "fixed_fee", precision: 4, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.integer "status", default: 10
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.integer "role", default: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicle_shipping_modes", force: :cascade do |t|
    t.integer "vehicle_id", null: false
    t.integer "shipping_mode_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shipping_mode_id"], name: "index_vehicle_shipping_modes_on_shipping_mode_id"
    t.index ["vehicle_id"], name: "index_vehicle_shipping_modes_on_vehicle_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "plate_number"
    t.string "model"
    t.string "brand"
    t.integer "year"
    t.integer "max_capacity"
    t.integer "activity", default: 5
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "delivery_times", "shipping_modes"
  add_foreign_key "distance_based_fees", "shipping_modes"
  add_foreign_key "full_addresses", "service_orders"
  add_foreign_key "vehicle_shipping_modes", "shipping_modes"
  add_foreign_key "vehicle_shipping_modes", "vehicles"
end
