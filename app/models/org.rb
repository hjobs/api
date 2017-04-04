class Org < ApplicationRecord
  has_many :employers, dependent: :destroy
  
  has_many :org_jobs, dependent: :destroy
  has_many :jobs, through: :org_jobs

  has_many :logs, dependent: :nullify

  has_many :ads, dependent: :nullify
end
