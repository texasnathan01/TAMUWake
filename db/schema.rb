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

ActiveRecord::Schema[7.0].define(version: 2023_04_05_032343) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", null: false
    t.string "uid"
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "is_approved", default: false
    t.string "uin", default: ""
    t.string "address", default: ""
    t.integer "role_id", default: 0
    t.boolean "aor_completed", default: false
    t.boolean "boat_waiver_completed", default: false
    t.boolean "dues_completed", default: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "receipts", force: :cascade do |t|
    t.integer "receipt_id"
    t.float "value"
    t.date "date_made"
    t.date "date_approved"
    t.date "date_refunded"
    t.integer "stage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_link"
    t.bigint "admin_id"
    t.index ["admin_id"], name: "index_receipts_on_admin_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "role_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "set_drivers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "admin_id"
    t.bigint "wakeboard_set_id"
    t.index ["admin_id"], name: "index_set_drivers_on_admin_id"
    t.index ["wakeboard_set_id"], name: "index_set_drivers_on_wakeboard_set_id"
  end

  create_table "set_riders", force: :cascade do |t|
    t.datetime "date_registered", precision: nil
    t.bigint "wakeboard_set_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "as_dib"
    t.bigint "admin_id"
    t.index ["admin_id"], name: "index_set_riders_on_admin_id"
    t.index ["wakeboard_set_id"], name: "index_set_riders_on_wakeboard_set_id"
  end

  create_table "set_roles", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "admin_id"
    t.index ["admin_id"], name: "index_set_roles_on_admin_id"
    t.index ["role_id"], name: "index_set_roles_on_role_id"
  end

  create_table "wakeboard_sets", force: :cascade do |t|
    t.datetime "scheduled_date", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "dib_count", default: 0
    t.integer "dib_limit", default: 4
    t.integer "chib_count", default: 0
    t.integer "chib_limit", default: 3
    t.integer "driver_count", default: 0
    t.integer "driver_limit", default: 2
  end

  add_foreign_key "receipts", "admins"
  add_foreign_key "set_drivers", "admins"
  add_foreign_key "set_drivers", "wakeboard_sets"
  add_foreign_key "set_riders", "admins"
  add_foreign_key "set_riders", "wakeboard_sets"
  add_foreign_key "set_roles", "admins"
  add_foreign_key "set_roles", "roles"
end
