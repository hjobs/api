class Log < ApplicationRecord
  belongs_to :job, :optional => true
  belongs_to :employee, :optional => true
  belongs_to :employer, :optional => true
  belongs_to :org, :optional => true
  belongs_to :job_type, :optional => true
end
