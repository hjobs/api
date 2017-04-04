class Employer < ApplicationRecord
  has_secure_password
  
  belongs_to :org

  has_many :employer_jobs, dependent: :destroy
  has_many :jobs, through: :employer_jobs

  has_many :logs, dependent: :nullify

  has_many :ads, dependent: :nullify
end
