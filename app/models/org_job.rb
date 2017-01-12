class OrgJob < ApplicationRecord
  belongs_to :org
  belongs_to :job
end
