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

ActiveRecord::Schema.define(version: 20151002205605) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "domains", force: :cascade do |t|
    t.string "value"
  end

  create_table "natures", force: :cascade do |t|
    t.string "value"
  end

  create_table "subdomains", force: :cascade do |t|
    t.string "value"
  end

  create_table "user_history", force: :cascade do |t|
    t.integer  "id_user"
    t.integer  "id_domain"
    t.integer  "id_subdomain"
    t.integer  "id_nature"
    t.string   "city"
    t.string   "mounth"
    t.string   "year"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "favorite"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
