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

ActiveRecord::Schema.define(version: 20140717140029) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "post_id",    null: false
    t.string   "body",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "families", force: true do |t|
    t.string   "surname",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "family_members", force: true do |t|
    t.integer  "family_id",                     null: false
    t.integer  "user_id",                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",       default: "member", null: false
  end

  add_index "family_members", ["user_id", "family_id"], name: "index_family_members_on_user_id_and_family_id", unique: true, using: :btree

  create_table "family_posts", force: true do |t|
    t.integer  "family_id",  null: false
    t.integer  "post_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitees", force: true do |t|
    t.string   "name",                           null: false
    t.string   "email",                          null: false
    t.string   "status",     default: "pending", null: false
    t.integer  "family_id",                      null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_images", force: true do |t|
    t.integer  "post_id",    null: false
    t.string   "url",        null: false
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_videos", force: true do |t|
    t.integer  "post_id",    null: false
    t.string   "title"
    t.string   "url",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "title",      null: false
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "event_date", null: false
  end

  create_table "users", force: true do |t|
    t.string   "first_name",                          null: false
    t.string   "last_name",                           null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
