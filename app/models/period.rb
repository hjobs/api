class Period < ApplicationRecord
  has_many :job_periods
  has_many :jobs, through: :job_periods
end
