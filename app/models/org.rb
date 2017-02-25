class Org < ApplicationRecord
  has_many :employers, dependent: :destroy
  
  has_many :org_jobs
  has_many :jobs, through: :org_jobs
end
