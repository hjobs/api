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

ActiveRecord::Schema.define(version: 20170119155320) do

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

  create_table "employee_projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "status"
    t.text     "message",     limit: 65535
    t.integer  "project_id"
    t.integer  "employee_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["employee_id"], name: "index_employee_projects_on_employee_id", using: :btree
    t.index ["project_id"], name: "index_employee_projects_on_project_id", using: :btree
  end

  create_table "employees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "name"
    t.string   "description"
    t.string   "country"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "employers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "name"
    t.string   "description"
    t.integer  "org_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["org_id"], name: "index_employers_on_org_id", using: :btree
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
  end

  create_table "org_jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "org_id"
    t.integer  "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_org_jobs_on_job_id", using: :btree
    t.index ["org_id"], name: "index_org_jobs_on_org_id", using: :btree
  end

  create_table "org_projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "org_id"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["org_id"], name: "index_org_projects_on_org_id", using: :btree
    t.index ["project_id"], name: "index_org_projects_on_project_id", using: :btree
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
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "description",    limit: 65535
    t.string   "start_date"
    t.string   "end_date"
    t.datetime "deadline"
    t.string   "reward_type"
    t.integer  "reward_money"
    t.string   "reward_other"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "attachment_url"
  end

  add_foreign_key "employee_jobs", "employees"
  add_foreign_key "employee_jobs", "jobs"
  add_foreign_key "employee_projects", "employees"
  add_foreign_key "employee_projects", "projects"
  add_foreign_key "employers", "orgs"
  add_foreign_key "org_jobs", "jobs"
  add_foreign_key "org_jobs", "orgs"
  add_foreign_key "org_projects", "orgs"
  add_foreign_key "org_projects", "projects"
end
