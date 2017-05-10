class JobExp < ApplicationRecord
  belongs_to :employee
  belongs_to :location, :optional => true
  belongs_to :org, :optional => true

  validates :time_from, presence: true
  validates :position, presence: true
  validates :time_to, presence: true, if: Proc.new { |obj| !obj.working }
  validates :org, presence: true, if: Proc.new { |obj| !obj.company_name }

  accepts_nested_attributes_for :location
end
