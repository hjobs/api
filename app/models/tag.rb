class Tag < ApplicationRecord
  enum group: [ :others, :industry, :role, :commitment ]
  has_many :job_tags
  has_many :jobs, through: :job_tags
end
