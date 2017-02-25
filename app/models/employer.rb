class Employer < ApplicationRecord
  has_secure_password
  
  belongs_to :org

  has_many :employer_jobs
  has_many :jobs, through: :employer_jobs
end
