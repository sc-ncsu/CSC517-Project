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

ActiveRecord::Schema[7.0].define(version: 2023_10_03_235817) do
  create_table "bookings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "train_id", null: false
    t.string "booking_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price"
    t.index ["train_id"], name: "index_bookings_on_train_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.text "feedback"
    t.integer "user_id", null: false
    t.integer "train_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["train_id"], name: "index_reviews_on_train_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "trains", force: :cascade do |t|
    t.string "number"
    t.string "departure_station"
    t.string "termination_station"
    t.date "departure_date"
    t.time "departure_time"
    t.date "arrival_date"
    t.time "arrival_time"
    t.decimal "ticket_price"
    t.integer "train_capacity"
    t.integer "seats_left"
    t.decimal "average_rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email_address"
    t.string "password_digest"
    t.text "address"
    t.string "phone_number"
    t.string "credit_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "bookings", "trains"
  add_foreign_key "bookings", "users"
  add_foreign_key "reviews", "trains"
  add_foreign_key "reviews", "users"
end
