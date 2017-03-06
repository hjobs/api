class Location < ApplicationRecord
  has_many :job_locations
  has_many :jobs, through: :job_locations
end
