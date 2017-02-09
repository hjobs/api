class Org < ApplicationRecord
  has_many :employers, dependent: :destroy
  has_many :org_jobs
  has_many :jobs, through: :org_jobs
  has_many :org_projects
  has_many :projects, through: :org_projects
end
