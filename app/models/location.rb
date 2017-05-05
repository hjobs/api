class Location < ApplicationRecord
  has_many :job_locations, :dependent => :destroy
  has_many :jobs, through: :job_locations
  has_many :employees
end
