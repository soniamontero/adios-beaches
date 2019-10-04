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

ActiveRecord::Schema.define(version: 2019_10_04_071949) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dones", force: :cascade do |t|
    t.bigint "experience_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["experience_id"], name: "index_dones_on_experience_id"
    t.index ["user_id"], name: "index_dones_on_user_id"
  end

  create_table "experiences", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.integer "price", default: 0
    t.text "details"
    t.bigint "category_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_experiences_on_category_id"
    t.index ["user_id"], name: "index_experiences_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "experience_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["experience_id"], name: "index_favorites_on_experience_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.integer "batch_number"
    t.string "batch_location"
    t.string "github_username", null: false
    t.string "slack_username"
    t.boolean "visited_bali", default: false
    t.string "provider"
    t.string "uid"
    t.string "github_picture_url"
    t.string "token"
    t.boolean "first_login", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "experience_id"
    t.bigint "user_id"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["experience_id"], name: "index_votes_on_experience_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "dones", "experiences"
  add_foreign_key "dones", "users"
  add_foreign_key "experiences", "categories"
  add_foreign_key "experiences", "users"
  add_foreign_key "favorites", "experiences"
  add_foreign_key "favorites", "users"
  add_foreign_key "votes", "experiences"
  add_foreign_key "votes", "users"
end
