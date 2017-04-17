class Score < ApplicationRecord
  enum name: [:punctuality, :performance, :presentation]
  belongs_to :scorable, polymorphic: true
end
