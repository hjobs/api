class Org < ApplicationRecord
  has_many :employers, dependent: :destroy
  
  has_many :org_jobs, dependent: :destroy
  has_many :jobs, through: :org_jobs
  has_many :job_exps, :dependent => :nullify

  has_many :org_locations, dependent: :destroy
  has_many :locations, through: :org_locations

  has_many :logs, dependent: :nullify

  has_many :ads, dependent: :nullify

  before_save :verify_logo

  private
    def verify_logo
      if !self.logo || self.logo.empty?
        self.logo = "https://dummyimage.com/250/EEE/111.png?text=" + self.name.sub(/ /, "+")
      else
        self.logo.sub! "dl=0", "raw=1"
      end
    end
end
