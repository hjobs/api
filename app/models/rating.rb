class Rating < ApplicationRecord
  enum name: [:punctuality, :performance, :presentation]
  belongs_to :ratable, polymorphic: true
end
