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

ActiveRecord::Schema.define(version: 20170305124927) do

  create_table "employee_jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "status"
    t.text     "message",     limit: 65535
    t.integer  "job_id"
    t.integer  "employee_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["employee_id"], name: "index_employee_jobs_on_employee_id", using: :btree
    t.index ["job_id"], name: "index_employee_jobs_on_job_id", using: :btree
  end

  create_table "employees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "name"
    t.text     "description",     limit: 65535
    t.string   "country"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "employer_jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "employer_id"
    t.integer  "job_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["employer_id"], name: "index_employer_jobs_on_employer_id", using: :btree
    t.index ["job_id"], name: "index_employer_jobs_on_job_id", using: :btree
  end

  create_table "employers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "name"
    t.text     "description",     limit: 65535
    t.integer  "org_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "admin"
    t.index ["org_id"], name: "index_employers_on_org_id", using: :btree
  end

  create_table "employment_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_employment_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "job_id"
    t.integer  "employment_type_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["employment_type_id"], name: "index_job_employment_types_on_employment_type_id", using: :btree
    t.index ["job_id"], name: "index_job_employment_types_on_job_id", using: :btree
  end

  create_table "job_locations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "job_id"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["job_id"], name: "index_job_locations_on_job_id", using: :btree
    t.index ["location_id"], name: "index_job_locations_on_location_id", using: :btree
  end

  create_table "job_periods", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "job_id"
    t.integer  "period_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_job_periods_on_job_id", using: :btree
    t.index ["period_id"], name: "index_job_periods_on_period_id", using: :btree
  end

  create_table "jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "description",    limit: 65535
    t.datetime "deadline"
    t.string   "salary_type"
    t.integer  "salary_value"
    t.integer  "salary_high"
    t.integer  "salary_low"
    t.string   "salary_unit"
    t.string   "position"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "attachment_url"
    t.integer  "job_type"
  end

  create_table "locations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "country"
    t.string   "region"
    t.string   "city"
    t.string   "district"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "org_jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "org_id"
    t.integer  "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_org_jobs_on_job_id", using: :btree
    t.index ["org_id"], name: "index_org_jobs_on_org_id", using: :btree
  end

  create_table "orgs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "description", limit: 65535
    t.string   "country"
    t.string   "region"
    t.text     "address",     limit: 65535
    t.string   "logo"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "email"
    t.index ["email"], name: "index_orgs_on_email", using: :btree
  end

  create_table "periods", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.date     "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "employee_jobs", "employees"
  add_foreign_key "employee_jobs", "jobs"
  add_foreign_key "employer_jobs", "employers"
  add_foreign_key "employer_jobs", "jobs"
  add_foreign_key "employers", "orgs"
  add_foreign_key "job_employment_types", "employment_types"
  add_foreign_key "job_employment_types", "jobs"
  add_foreign_key "job_locations", "jobs"
  add_foreign_key "job_locations", "locations"
  add_foreign_key "job_periods", "jobs"
  add_foreign_key "job_periods", "periods"
  add_foreign_key "org_jobs", "jobs"
  add_foreign_key "org_jobs", "orgs"
end
