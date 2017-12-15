class Job < ApplicationRecord
  enum job_type: [:quick, :stable, :intern, :project]

  has_many :job_periods, :dependent => :destroy
  has_many :periods, through: :job_periods

  has_many :job_locations, :dependent => :destroy
  has_many :locations, through: :job_locations
  
  has_one :employer_job, :dependent => :destroy
  has_one :employer, through: :employer_job

  has_many :org_jobs, :dependent => :destroy
  has_many :orgs, through: :org_jobs

  has_many :employee_jobs, :dependent => :nullify
  has_many :employees, through: :employee_jobs
  
  has_many :job_employment_types, :dependent => :destroy
  has_many :employment_types, through: :job_employment_types

  has_many :job_langs, :dependent => :destroy
  has_many :langs, through: :job_langs

  has_many :job_tags
  has_many :tags, through: :job_tags

  has_many :logs, :dependent => :nullify

  before_save :check
  default_scope { order(updated_at: :desc) }
  scope :after_today, -> val { left_outer_joins(:periods).where("periods.id IS NULL OR periods.date >= ?", Date.today).distinct }
  scope :by_job_type, -> job_type { where({job_type: job_type}) }
  scope :filter, -> codes { joins(:tags).where(
    codes.collect{|code| "tags.code = ''" + code + "''"}.join(" && ")
  ).distinct}
  scope :offset_by, -> num { limit(30).offset(num) }
  

  def check
    self.has_bonus = false if self.has_bonus.nil?
    self.locations = self.employer.org.locations if self.default_location
  end
end
