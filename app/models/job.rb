class Job < ApplicationRecord
  enum job_type: [:casual, :stable]
  
  has_one :employer_job, :dependent => :destroy
  has_one :employer, through: :employer_job

  has_many :org_jobs, :dependent => :destroy
  has_many :orgs, through: :org_job

  has_many :employee_jobs, :dependent => :nullify
  has_many :employees, through: :employee_jobs
  
  has_many :job_employment_types, :dependent => :destroy
  has_many :employment_types, through: :job_employment_types
end
