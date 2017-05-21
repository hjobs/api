class OrgLocation < ApplicationRecord
  belongs_to :org
  belongs_to :location
end
