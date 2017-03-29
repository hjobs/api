class JobLang < ApplicationRecord
  belongs_to :job
  belongs_to :lang
end
