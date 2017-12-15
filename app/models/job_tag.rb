class JobTag < ApplicationRecord
  belongs_to :tag
  belongs_to :job
end
