class JobEmploymentType < ApplicationRecord
  belongs_to :job
  belongs_to :employment_type
end
