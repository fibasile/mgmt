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

ActiveRecord::Schema.define(version: 20151108164902) do

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
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.boolean  "can_grade",           default: true
    t.datetime "grades_submitted_at"
  end

  add_index "course_tutors", ["course_id", "user_id"], name: "index_course_tutors_on_course_id_and_user_id", unique: true, using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "subtitle"
    t.text     "description"
    t.integer  "credits"
    t.boolean  "published",              default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "ancestry"
    t.string   "workflow_state"
    t.date     "starts_on"
    t.integer  "students_counter_cache", default: 0,     null: false
    t.integer  "grades_counter_cache",   default: 0,     null: false
  end

  add_index "courses", ["ancestry"], name: "index_courses_on_ancestry", using: :btree
  add_index "courses", ["workflow_state"], name: "index_courses_on_workflow_state", using: :btree

  create_table "grades", force: :cascade do |t|
    t.integer  "course_id",                             null: false
    t.integer  "gradee_id",                             null: false
    t.integer  "grader_id"
    t.decimal  "value",         precision: 6, scale: 2
    t.text     "public_notes"
    t.text     "private_notes"
    t.datetime "approved_at"
    t.datetime "viewed_at"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "group"
  end

  add_index "grades", ["course_id", "gradee_id", "grader_id"], name: "index_grades_on_course_id_and_gradee_id_and_grader_id", using: :btree
  add_index "grades", ["grader_id"], name: "index_grades_on_grader_id", using: :btree
  add_index "grades", ["group"], name: "index_grades_on_group", using: :btree

  create_table "lab_programs", force: :cascade do |t|
    t.integer "lab_id"
    t.integer "program_id"
  end

  add_index "lab_programs", ["lab_id", "program_id"], name: "index_lab_programs_on_lab_id_and_program_id", unique: true, using: :btree

  create_table "labs", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "logo_url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "program_courses", force: :cascade do |t|
    t.integer  "program_id"
    t.integer  "course_id"
    t.integer  "credits"
    t.boolean  "published",  default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "program_courses", ["program_id", "course_id"], name: "index_program_courses_on_program_id_and_course_id", unique: true, using: :btree
  add_index "program_courses", ["published"], name: "index_program_courses_on_published", using: :btree

  create_table "program_students", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "program_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "lab_id"
  end

  add_index "program_students", ["user_id", "program_id"], name: "index_program_students_on_user_id_and_program_id", unique: true, using: :btree

  create_table "programs", force: :cascade do |t|
    t.string   "name"
    t.date     "starts_on"
    t.date     "ends_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "last_sign_in_at"
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
    t.hstore   "temp_data"
    t.string   "password_digest"
    t.string   "invitation_code"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.integer  "course_type"
    t.integer  "clearance",              default: 0
    t.datetime "invited_at"
    t.datetime "announced_at"
  end

  add_index "users", ["clearance"], name: "index_users_on_clearance", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "course_students", "courses"
  add_foreign_key "course_students", "users"
  add_foreign_key "course_tutors", "courses"
  add_foreign_key "course_tutors", "users"
  add_foreign_key "grades", "courses"
  add_foreign_key "grades", "users", column: "gradee_id"
  add_foreign_key "grades", "users", column: "grader_id"
  add_foreign_key "lab_programs", "labs"
  add_foreign_key "lab_programs", "programs"
  add_foreign_key "program_courses", "courses"
  add_foreign_key "program_courses", "programs"
  add_foreign_key "program_students", "labs"
  add_foreign_key "program_students", "programs"
  add_foreign_key "program_students", "users"
end
