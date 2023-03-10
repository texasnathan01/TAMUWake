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

ActiveRecord::Schema[7.0].define(version: 2023_03_01_202335) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", null: false
    t.string "full_name"
    t.string "uid"
    t.string "avatar_url"
    t.boolean "is_approved", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

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
    t.string "image_link"
  end

  create_table "riders", force: :cascade do |t|
    t.boolean "documents_signed"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_riders_on_user_id"
  end

  create_table "set_riders", force: :cascade do |t|
    t.datetime "date_registered", precision: nil
    t.bigint "rider_id", null: false
    t.bigint "wakeboard_set_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rider_id"], name: "index_set_riders_on_rider_id"
    t.index ["wakeboard_set_id"], name: "index_set_riders_on_wakeboard_set_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "firstname"
    t.string "lastname"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "documents_signed", default: false
    t.integer "role_id", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "wakeboard_sets", force: :cascade do |t|
    t.integer "rider_limit"
    t.integer "current_rider_count", default: 0
    t.datetime "scheduled_date", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_wakeboard_sets_on_user_id"
  end

  add_foreign_key "riders", "users"
  add_foreign_key "set_riders", "riders"
  add_foreign_key "set_riders", "wakeboard_sets"
  add_foreign_key "wakeboard_sets", "users"
end
