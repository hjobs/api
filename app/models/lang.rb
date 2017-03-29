class Lang < ApplicationRecord
  has_many :job_langs, :dependent => :destroy
  has_many :jobs, through: :job_langs
end
