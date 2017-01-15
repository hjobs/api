class EmployeeProject < ApplicationRecord
  has_secure_password
  belongs_to :project
  belongs_to :employee
end
