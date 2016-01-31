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

ActiveRecord::Schema.define(version: 20160130182820) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "organizations", force: :cascade do |t|
    t.string   "ein"
    t.string   "legal_name"
    t.string   "city"
    t.integer  "state_id"
    t.string   "country"
    t.string   "status"
    t.string   "irs_code_subsection"
    t.string   "zip"
    t.string   "asset_code"
    t.string   "income_code"
    t.integer  "asset_amount"
    t.integer  "income_amount"
    t.integer  "revenue_990"
    t.string   "affiliation_code"
    t.string   "deductibility_code"
    t.date     "ruling_date"
    t.date     "last_return"
    t.integer  "accounting_start"
    t.integer  "accounting_end"
    t.string   "organization_code"
    t.string   "classification_code_1"
    t.string   "classification_code_2"
    t.string   "classification_code_3"
    t.string   "classification_code_4"
    t.string   "foundation_code_general"
    t.string   "foundation_code_specific"
    t.string   "filing_requirement"
    t.string   "pf_return_requirement"
    t.string   "activity_code"
    t.string   "activity_category"
    t.string   "ntee_category"
    t.string   "ntee"
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
    t.datetime "status_last_checked",            default: '2016-01-31 02:52:49'
    t.datetime "asset_code_last_checked",        default: '2016-01-31 02:52:49'
    t.datetime "income_code_last_checked",       default: '2016-01-31 02:52:49'
    t.datetime "asset_amount_last_checked",      default: '2016-01-31 02:52:49'
    t.datetime "income_amount_last_checked",     default: '2016-01-31 02:52:49'
    t.datetime "revenue_990_last_checked",       default: '2016-01-31 02:52:49'
    t.datetime "affiliation_code_last_checked",  default: '2016-01-31 02:52:49'
    t.datetime "last_return_last_checked",       default: '2016-01-31 02:52:50'
    t.datetime "organization_code_last_checked", default: '2016-01-31 02:52:50'
    t.datetime "activity_code_last_checked",     default: '2016-01-31 02:52:50'
    t.datetime "activity_category_last_checked", default: '2016-01-31 02:52:50'
    t.datetime "ntee_category_last_checked",     default: '2016-01-31 02:52:50'
    t.datetime "ntee_sub_category_last_checked", default: '2016-01-31 02:52:50'
  end

  add_index "organizations", ["state_id"], name: "index_organizations_on_state_id", using: :btree

  create_table "postcards", force: :cascade do |t|
    t.string   "ein"
    t.integer  "tax_year"
    t.string   "organization_name"
    t.boolean  "gross_receipts_under_25k"
    t.boolean  "terminated"
    t.date     "tax_period_begin_date"
    t.date     "tax_period_end_date"
    t.string   "website_url"
    t.string   "officer_name"
    t.string   "officer_address_line_1"
    t.string   "officer_address_line_2"
    t.string   "officer_address_city"
    t.string   "officer_address_province"
    t.integer  "officer_address_state_id"
    t.string   "officer_address_postal_code"
    t.string   "officer_address_country"
    t.string   "organization_address_line_1"
    t.string   "organization_address_line_2"
    t.string   "organization_address_city"
    t.string   "organization_address_province"
    t.integer  "organization_address_state_id"
    t.string   "organization_address_postal_code"
    t.string   "organization_address_country"
    t.string   "doing_business_as_name_1"
    t.string   "doing_business_as_name_2"
    t.string   "doing_business_as_name_3"
    t.integer  "organization_id"
    t.datetime "created_at",                                                                    null: false
    t.datetime "updated_at",                                                                    null: false
    t.datetime "terminated_last_checked",                       default: '2016-01-31 02:52:50'
    t.datetime "organization_address_line_1_last_checked",      default: '2016-01-31 02:52:50'
    t.datetime "organization_address_state_id_last_checked",    default: '2016-01-31 02:52:50'
    t.datetime "organization_address_postal_code_last_checked", default: '2016-01-31 02:52:50'
  end

  add_index "postcards", ["officer_address_state_id"], name: "index_postcards_on_officer_address_state_id", using: :btree
  add_index "postcards", ["organization_address_state_id"], name: "index_postcards_on_organization_address_state_id", using: :btree
  add_index "postcards", ["organization_id"], name: "index_postcards_on_organization_id", using: :btree

  create_table "revokedorganizations", force: :cascade do |t|
    t.string   "ein"
    t.string   "legal_name"
    t.string   "doing_business_as_name"
    t.string   "organization_address"
    t.string   "city"
    t.integer  "state_id"
    t.string   "exemption_type"
    t.date     "revocation_date"
    t.date     "revocation_posting_date"
    t.date     "exemption_reinstatement_date"
    t.integer  "organization_id"
    t.datetime "created_at",                                                                null: false
    t.datetime "updated_at",                                                                null: false
    t.datetime "city_last_checked",                         default: '2016-01-31 02:52:50'
    t.datetime "legal_name_last_checked",                   default: '2016-01-31 02:52:50'
    t.datetime "exemption_type_last_checked",               default: '2016-01-31 02:52:50'
    t.datetime "revocation_date_last_checked",              default: '2016-01-31 02:52:50'
    t.datetime "revocation_posting_date_last_checked",      default: '2016-01-31 02:52:50'
    t.datetime "exemption_reinstatement_date_last_checked", default: '2016-01-31 02:52:50'
  end

  add_index "revokedorganizations", ["organization_id"], name: "index_revokedorganizations_on_organization_id", using: :btree
  add_index "revokedorganizations", ["state_id"], name: "index_revokedorganizations_on_state_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
