class OrgProject < ApplicationRecord
  belongs_to :org
  belongs_to :project
end
