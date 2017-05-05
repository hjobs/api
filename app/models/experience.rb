class Experience < ApplicationRecord
  belongs_to :employees
  belongs_to :org, :optional => true
  belongs_to :location, :optional => true

  validates :position, presence: true
  validates :time_start, presence: true
end
