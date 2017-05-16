class Ad < ApplicationRecord
  belongs_to :org, :optional => true
  belongs_to :employer, :optional => true

  has_many :log, dependent: :nullify
end
