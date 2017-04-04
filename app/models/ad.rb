class Ad < ApplicationRecord
  belongs_to :org, :optional => true
  belongs_to :employer, :optional => true
end
