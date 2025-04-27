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

ActiveRecord::Schema[7.1].define(version: 2025_04_27_042341) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "reader"
    t.string "checkpost"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "vehicle_number"
    t.string "checkpost"
    t.string "owner"
    t.string "char_dham_registration_number"
    t.string "green_card_status"
    t.string "trip_card_status"
    t.date "check_date"
    t.integer "number_of_pilgrims"
    t.string "dham_destinations"
    t.date "return_date"
    t.boolean "registered_in_uttarakhand"
    t.text "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["char_dham_registration_number"], name: "index_vehicles_on_char_dham_registration_number"
    t.index ["check_date"], name: "index_vehicles_on_check_date"
    t.index ["checkpost"], name: "index_vehicles_on_checkpost"
    t.index ["owner"], name: "index_vehicles_on_owner"
    t.index ["vehicle_number"], name: "index_vehicles_on_vehicle_number"
  end

end
