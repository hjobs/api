class Employee < ApplicationRecord
  has_secure_password
  has_many :employee_jobs
  has_many :jobs, through: :employee_jobs
  has_many :employee_projects
  has_many :projects, through: :employee_projects
end
