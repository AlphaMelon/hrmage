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

ActiveRecord::Schema.define(version: 20140317060449) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "access_levels", force: true do |t|
    t.integer  "account_organization_id"
    t.integer  "department_id"
    t.string   "access_level"
    t.string   "class_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "account_organizations", force: true do |t|
    t.integer  "account_id"
    t.integer  "organization_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "claim_subject"
    t.string   "department"
    t.string   "employee"
    t.string   "leave_type"
    t.string   "payslip"
    t.string   "payslip_setting"
    t.string   "position"
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

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "admin_users", force: true do |t|
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

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "claim_subjects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

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
    t.datetime "deleted_at"
  end

  add_index "claims", ["deleted_at"], name: "index_claims_on_deleted_at", using: :btree

  create_table "country_holiday_settings", force: true do |t|
    t.integer  "country_setting_id"
    t.string   "name"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "country_settings", force: true do |t|
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
    t.datetime "deleted_at"
  end

  add_index "departments", ["deleted_at"], name: "index_departments_on_deleted_at", using: :btree

  create_table "documents", force: true do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "employee_id"
    t.datetime "deleted_at"
  end

  add_index "documents", ["deleted_at"], name: "index_documents_on_deleted_at", using: :btree

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
    t.boolean  "can_self_approve"
    t.integer  "base_salary_cents"
    t.string   "employee_identification"
    t.datetime "deleted_at"
  end

  add_index "employees", ["deleted_at"], name: "index_employees_on_deleted_at", using: :btree

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
    t.datetime "deleted_at"
  end

  add_index "leave_types", ["deleted_at"], name: "index_leave_types_on_deleted_at", using: :btree

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
    t.datetime "deleted_at"
  end

  add_index "leaves", ["deleted_at"], name: "index_leaves_on_deleted_at", using: :btree

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
    t.string   "country"
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
    t.datetime "deleted_at"
  end

  add_index "payslip_settings", ["deleted_at"], name: "index_payslip_settings_on_deleted_at", using: :btree

  create_table "payslips", force: true do |t|
    t.integer  "employee_id"
    t.integer  "organization_id"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "commission_cents"
    t.integer  "base_salary_cents"
    t.datetime "deleted_at"
  end

  add_index "payslips", ["deleted_at"], name: "index_payslips_on_deleted_at", using: :btree

  create_table "position_default_variables", force: true do |t|
    t.integer  "position_id"
    t.integer  "leave_type_id"
    t.integer  "max_leaves_seconds"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.boolean  "can_approve_leave"
    t.boolean  "can_approve_claim"
    t.integer  "monthly_max_claims_cents"
    t.datetime "deleted_at"
  end

  add_index "positions", ["deleted_at"], name: "index_positions_on_deleted_at", using: :btree

end
