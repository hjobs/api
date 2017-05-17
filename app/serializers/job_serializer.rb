class JobSerializer < ActiveModel::Serializer
  attributes  :id,
              :title,
              :description,
              :salary_type,
              :salary_value,
              :salary_high,
              :salary_low,
              :salary_unit,
              :has_bonus,
              :bonus_value,
              :position,
              :created_at,
              :updated_at,
              :attachment_url,
              :job_type,
              :event,
              :view_count,
              :applicants_count

  has_one :employer
  has_many :orgs
  has_many :periods
  has_many :locations
  has_many :employment_types
  has_many :employees
  has_many :langs

  def view_count
    object.logs.where(:name => "ViewJob").count
  end

  def applicants_count
    object.employee_jobs.count
  end
end
