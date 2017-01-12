class Job < ApplicationRecord
  has_one :org_job
  has_one :org, through: :org_job
  has_many :employee_jobs
  has_many :employees, through: :employee_jobs
end
