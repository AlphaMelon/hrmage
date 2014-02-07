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

ActiveRecord::Schema.define(version: 20140206065624) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "account_organizations", force: true do |t|
    t.integer  "account_id"
    t.integer  "organization_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "accounts", force: true do |t|
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
  end

  add_index "accounts", ["email"], name: "index_accounts_on_email", unique: true, using: :btree
  add_index "accounts", ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true, using: :btree

  create_table "claims", force: true do |t|
    t.string   "subject"
    t.datetime "date"
    t.text     "comment"
    t.string   "image"
    t.string   "status"
    t.integer  "organization_id"
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "action_by_id"
    t.integer  "amount_cents"
  end

  create_table "departments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  create_table "documents", force: true do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "employee_id"
  end

  create_table "employee_departments", force: true do |t|
    t.integer  "employee_id"
    t.integer  "department_id"
    t.boolean  "leader",        default: false
    t.hstore   "properties"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employee_variables", force: true do |t|
    t.integer  "employee_id"
    t.integer  "leave_type_id"
    t.integer  "available_leaves_seconds"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "mobile_contact"
    t.string   "address"
    t.string   "photo"
    t.hstore   "properties"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position_id"
    t.integer  "account_id"
    t.integer  "organization_id"
    t.integer  "available_claims_cents"
    t.boolean  "can_self_approve"
    t.integer  "base_salary_cents"
  end

  create_table "leave_types", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "affected_entity",       array: true
    t.string   "type"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "approval_needed"
    t.string   "colour"
    t.integer  "default_count_seconds"
  end

  create_table "leaves", force: true do |t|
    t.datetime "start_date"
    t.string   "comment"
    t.string   "status"
    t.hstore   "properties"
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
    t.integer  "leave_type_id"
    t.integer  "duration_seconds"
    t.integer  "action_by_id"
  end

  create_table "organization_holidays", force: true do |t|
    t.string   "name"
    t.date     "date"
    t.integer  "organization_setting_id"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organization_settings", force: true do |t|
    t.integer  "organization_id"
    t.integer  "monday"
    t.integer  "tuesday"
    t.integer  "wednesday"
    t.integer  "thursday"
    t.integer  "friday"
    t.integer  "saturday"
    t.integer  "sunday"
    t.integer  "minimum_leave"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.string   "domain"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "default_currency"
  end

  create_table "payslip_calculations", force: true do |t|
    t.integer  "payslip_id"
    t.integer  "payslip_setting_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payslip_settings", force: true do |t|
    t.integer  "organization_id"
    t.string   "name"
    t.integer  "value"
    t.string   "maths"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payslips", force: true do |t|
    t.integer  "employee_id"
    t.integer  "organization_id"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "commission_cents"
    t.integer  "base_salary_cents"
  end

  create_table "position_settings", force: true do |t|
    t.integer  "position_id"
    t.integer  "leave_type_id"
    t.integer  "max_leaves_seconds"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "positions", force: true do |t|
    t.string   "name"
    t.hstore   "properties"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
    t.integer  "max_claims_cents"
    t.boolean  "can_approve_leave"
    t.boolean  "can_approve_claim"
  end

end
