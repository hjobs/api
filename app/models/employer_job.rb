class EmployerJob < ApplicationRecord
  belongs_to :employer
  belongs_to :job
end
