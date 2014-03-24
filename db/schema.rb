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

ActiveRecord::Schema.define(version: 20140302232306) do

  create_table "courses", force: true do |t|
    t.string   "name"
    t.string   "filelocation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "size"
    t.boolean  "grouped"
    t.string   "course_code"
    t.integer  "semester"
    t.integer  "year"
    t.integer  "user_id"
    t.boolean  "confirmed"
  end

  create_table "data_files", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.integer  "number"
    t.integer  "fitness"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_id"
  end

  create_table "landings", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scgs", force: true do |t|
    t.integer  "size"
    t.integer  "student_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
  end

  create_table "sort_configs", force: true do |t|
    t.integer  "course_id"
    t.integer  "algorithm"
    t.boolean  "age"
    t.boolean  "gpa"
    t.boolean  "degree"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_size"
  end

  create_table "students", force: true do |t|
    t.string   "student_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "degree"
    t.integer  "course_id"
    t.integer  "group_id"
    t.string   "email"
    t.integer  "gender"
    t.integer  "age"
    t.float    "GPA"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "uploads", force: true do |t|
    t.string   "username"
    t.string   "file"
    t.string   "file_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "uploads", ["file_id"], name: "index_uploads_on_file_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_id"
    t.date     "first_use"
    t.date     "last_login"
  end

end
