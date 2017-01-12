class Employer < ApplicationRecord
  has_secure_password
  belongs_to :org
end
