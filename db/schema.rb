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

ActiveRecord::Schema[7.0].define(version: 2023_02_11_214435) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "receipts", force: :cascade do |t|
    t.integer "receipt_id"
    t.integer "user_id"
    t.float "value"
    t.date "date_made"
    t.date "date_approved"
    t.date "date_refunded"
    t.integer "stage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "firstname"
    t.string "lastname"
    t.string "password"
    t.boolean "isRider"
    t.boolean "isDriver"
    t.boolean "isAdmin"
    t.boolean "isTreasurer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
