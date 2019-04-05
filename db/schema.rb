# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20190315171050) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "user_descs", force: :cascade do |t|
    t.string   "lname"
    t.string   "fname"
    t.string   "sname"
    t.text     "address"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_descs", ["user_id"], name: "index_user_descs_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "user_login"
    t.string   "user_password"
    t.string   "email"
    t.integer  "is_real_admin"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "hobbies"
  end

  add_foreign_key "user_descs", "users"
end
