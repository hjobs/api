class EmploymentType < ApplicationRecord
  has_many :job_employment_types
  has_many :jobs, through: :job_employment_types
end
