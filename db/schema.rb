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

ActiveRecord::Schema.define(version: 20170417055250) do

  create_table "ads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "link"
    t.string   "image"
    t.string   "title"
    t.text     "description", limit: 65535
    t.integer  "org_id"
    t.integer  "employer_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["employer_id"], name: "index_ads_on_employer_id", using: :btree
    t.index ["org_id"], name: "index_ads_on_org_id", using: :btree
  end

  create_table "auths", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "authable_type"
    t.integer  "authable_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["authable_type", "authable_id"], name: "index_auths_on_authable_type_and_authable_id", using: :btree
  end

  create_table "employee_jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "status",      limit: 255
    t.text     "message",     limit: 65535
    t.integer  "job_id"
    t.integer  "employee_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["employee_id"], name: "index_employee_jobs_on_employee_id", using: :btree
    t.index ["job_id"], name: "index_employee_jobs_on_job_id", using: :btree
  end

  create_table "employees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.string   "name",            limit: 255
    t.text     "description",     limit: 65535
    t.string   "country",         limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "pic_hd"
    t.string   "pic_sm"
    t.string   "first_name"
    t.string   "last_name"
  end

  create_table "employer_jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "employer_id"
    t.integer  "job_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["employer_id"], name: "index_employer_jobs_on_employer_id", using: :btree
    t.index ["job_id"], name: "index_employer_jobs_on_job_id", using: :btree
  end

  create_table "employers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.string   "name",            limit: 255
    t.text     "description",     limit: 65535
    t.integer  "org_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "admin"
    t.index ["org_id"], name: "index_employers_on_org_id", using: :btree
  end

  create_table "employment_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "job_employment_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "job_id"
    t.integer  "employment_type_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["employment_type_id"], name: "index_job_employment_types_on_employment_type_id", using: :btree
    t.index ["job_id"], name: "index_job_employment_types_on_job_id", using: :btree
  end

  create_table "job_langs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "job_id"
    t.integer  "lang_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_job_langs_on_job_id", using: :btree
    t.index ["lang_id"], name: "index_job_langs_on_lang_id", using: :btree
  end

  create_table "job_locations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "job_id"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["job_id"], name: "index_job_locations_on_job_id", using: :btree
    t.index ["location_id"], name: "index_job_locations_on_location_id", using: :btree
  end

  create_table "job_periods", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "job_id"
    t.integer  "period_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_job_periods_on_job_id", using: :btree
    t.index ["period_id"], name: "index_job_periods_on_period_id", using: :btree
  end

  create_table "job_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title",          limit: 255
    t.text     "description",    limit: 16777215
    t.datetime "deadline"
    t.string   "salary_type",    limit: 255
    t.text     "salary_value",   limit: 65535
    t.integer  "salary_high"
    t.integer  "salary_low"
    t.string   "salary_unit",    limit: 255
    t.string   "position",       limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "attachment_url", limit: 255
    t.integer  "job_type"
    t.string   "event"
  end

  create_table "langs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.string   "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "country",    limit: 255
    t.string   "region",     limit: 255
    t.string   "city",       limit: 255
    t.string   "district",   limit: 255
    t.string   "address",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name",        limit: 255
    t.string   "action",      limit: 255
    t.integer  "job_id"
    t.integer  "employee_id"
    t.integer  "employer_id"
    t.integer  "org_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "job_type_id"
    t.string   "component"
    t.string   "page"
    t.string   "target"
    t.index ["employee_id"], name: "index_logs_on_employee_id", using: :btree
    t.index ["employer_id"], name: "index_logs_on_employer_id", using: :btree
    t.index ["job_id"], name: "index_logs_on_job_id", using: :btree
    t.index ["job_type_id"], name: "index_logs_on_job_type_id", using: :btree
    t.index ["org_id"], name: "index_logs_on_org_id", using: :btree
  end

  create_table "org_jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "org_id"
    t.integer  "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_org_jobs_on_job_id", using: :btree
    t.index ["org_id"], name: "index_org_jobs_on_org_id", using: :btree
  end

  create_table "orgs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.string   "country",     limit: 255
    t.string   "region",      limit: 255
    t.text     "address",     limit: 65535
    t.string   "logo",        limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "email",       limit: 255
    t.index ["email"], name: "index_orgs_on_email", using: :btree
  end

  create_table "periods", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.date     "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "name"
    t.integer  "value"
    t.string   "ratable_type"
    t.integer  "ratable_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["ratable_type", "ratable_id"], name: "index_ratings_on_ratable_type_and_ratable_id", using: :btree
  end

  create_table "scores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "name"
    t.integer  "value"
    t.string   "scorable_type"
    t.integer  "scorable_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["scorable_type", "scorable_id"], name: "index_scores_on_scorable_type_and_scorable_id", using: :btree
  end

  add_foreign_key "ads", "employers"
  add_foreign_key "ads", "orgs"
  add_foreign_key "employee_jobs", "employees"
  add_foreign_key "employee_jobs", "jobs"
  add_foreign_key "employer_jobs", "employers"
  add_foreign_key "employer_jobs", "jobs"
  add_foreign_key "employers", "orgs"
  add_foreign_key "job_employment_types", "employment_types"
  add_foreign_key "job_employment_types", "jobs"
  add_foreign_key "job_langs", "jobs"
  add_foreign_key "job_langs", "langs"
  add_foreign_key "job_locations", "jobs"
  add_foreign_key "job_locations", "locations"
  add_foreign_key "job_periods", "jobs"
  add_foreign_key "job_periods", "periods"
  add_foreign_key "logs", "employees"
  add_foreign_key "logs", "employers"
  add_foreign_key "logs", "job_types"
  add_foreign_key "logs", "jobs"
  add_foreign_key "logs", "orgs"
  add_foreign_key "org_jobs", "jobs"
  add_foreign_key "org_jobs", "orgs"
end
