class Location < ApplicationRecord
  has_many :job_locations, :dependent => :destroy
  has_many :jobs, through: :job_locations
  has_many :employees, :dependent => :nullify
  has_many :job_exps, :dependent => :nullify
  has_many :org_locations, dependent: :destroy
  has_many :orgs, through: :org_locations

end
