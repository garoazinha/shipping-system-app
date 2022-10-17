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

ActiveRecord::Schema[7.0].define(version: 2022_10_16_223221) do
  create_table "closed_delivery_data", force: :cascade do |t|
    t.integer "status", default: 3
    t.integer "service_order_id", null: false
    t.datetime "closing_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "estimated_end_date"
    t.integer "delivery_datum_id", null: false
    t.index ["delivery_datum_id"], name: "index_closed_delivery_data_on_delivery_datum_id"
    t.index ["service_order_id"], name: "index_closed_delivery_data_on_service_order_id"
  end

  create_table "delay_reasons", force: :cascade do |t|
    t.string "reason_for_delay"
    t.integer "service_order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "closed_delivery_datum_id", null: false
    t.index ["closed_delivery_datum_id"], name: "index_delay_reasons_on_closed_delivery_datum_id"
    t.index ["service_order_id"], name: "index_delay_reasons_on_service_order_id"
  end

  create_table "delivery_data", force: :cascade do |t|
    t.integer "shipping_mode_id", null: false
    t.integer "service_order_id", null: false
    t.decimal "total_price", precision: 6, scale: 2
    t.integer "estimated_delivery_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "vehicle_id", null: false
    t.datetime "creation_date"
    t.datetime "end_date"
    t.index ["service_order_id"], name: "index_delivery_data_on_service_order_id"
    t.index ["shipping_mode_id"], name: "index_delivery_data_on_shipping_mode_id"
    t.index ["vehicle_id"], name: "index_delivery_data_on_vehicle_id"
  end

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
    t.decimal "fee", precision: 5, scale: 2
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

  create_table "weight_based_fees", force: :cascade do |t|
    t.integer "min_weight"
    t.integer "max_weight"
    t.decimal "fee_per_km", precision: 5, scale: 2
    t.integer "shipping_mode_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shipping_mode_id"], name: "index_weight_based_fees_on_shipping_mode_id"
  end

  add_foreign_key "closed_delivery_data", "delivery_data"
  add_foreign_key "closed_delivery_data", "service_orders"
  add_foreign_key "delay_reasons", "closed_delivery_data"
  add_foreign_key "delay_reasons", "service_orders"
  add_foreign_key "delivery_data", "service_orders"
  add_foreign_key "delivery_data", "shipping_modes"
  add_foreign_key "delivery_data", "vehicles"
  add_foreign_key "delivery_times", "shipping_modes"
  add_foreign_key "distance_based_fees", "shipping_modes"
  add_foreign_key "full_addresses", "service_orders"
  add_foreign_key "vehicle_shipping_modes", "shipping_modes"
  add_foreign_key "vehicle_shipping_modes", "vehicles"
  add_foreign_key "weight_based_fees", "shipping_modes"
end
