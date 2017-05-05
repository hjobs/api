class ProfileViewer < ApplicationRecord
  belongs_to :org
  belongs_to :employee
end
