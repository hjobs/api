class Lang < ApplicationRecord
  has_many :job_langs, :dependent => :destroy
  has_many :jobs, through: :job_langs

  has_many :lang_qs, :dependent => :destroy
  has_many :employees, through: :lang_qs
end
