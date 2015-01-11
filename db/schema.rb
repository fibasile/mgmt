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

ActiveRecord::Schema.define(version: 20150111162212) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "course_students", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "course_students", ["course_id", "user_id"], name: "index_course_students_on_course_id_and_user_id", unique: true, using: :btree

  create_table "course_tutors", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.string   "role"
    t.text     "role_description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "course_tutors", ["course_id", "user_id"], name: "index_course_tutors_on_course_id_and_user_id", unique: true, using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "subtitle"
    t.text     "description"
    t.integer  "credits"
    t.boolean  "published",   default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "grades", force: :cascade do |t|
    t.integer  "course_id",     null: false
    t.integer  "gradee_id",     null: false
    t.integer  "grader_id"
    t.integer  "value"
    t.text     "public_notes"
    t.text     "private_notes"
    t.datetime "approved_at"
    t.datetime "viewed_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "grades", ["course_id", "gradee_id"], name: "index_grades_on_course_id_and_gradee_id", unique: true, using: :btree
  add_index "grades", ["grader_id"], name: "index_grades_on_grader_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "country_code"
    t.string   "photo"
    t.text     "description"
    t.string   "gender"
    t.date     "dob"
    t.hstore   "meta"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "course_students", "courses"
  add_foreign_key "course_students", "users"
  add_foreign_key "course_tutors", "courses"
  add_foreign_key "course_tutors", "users"
  add_foreign_key "grades", "courses"
  add_foreign_key "grades", "users", column: "gradee_id"
  add_foreign_key "grades", "users", column: "grader_id"
end
