class JobPeriod < ApplicationRecord
  belongs_to :job
  belongs_to :period
end
