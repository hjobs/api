class LangQ < ApplicationRecord
  belongs_to :lang
  belongs_to :employee
  enum level: [ :basic, :good, :fluent ]
end
