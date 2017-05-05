class LangQ < ApplicationRecord
  belongs_to :lang
  belongs_to :employee
  enum level: [ :ok, :fluent, :native ]
end
