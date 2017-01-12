class EmployeeJob < ApplicationRecord
  belongs_to :job
  belongs_to :employee
end
