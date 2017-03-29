class JobSerializer < ActiveModel::Serializer
  attributes  :id,
              :title,
              :description,
              :salary_type,
              :salary_value,
              :salary_high,
              :salary_low,
              :salary_unit,
              :position,
              :created_at,
              :updated_at,
              :attachment_url,
              :job_type,
              :event

  has_one :employer
  has_many :orgs
  has_many :employees
  has_many :periods
  has_many :locations
  has_many :employment_types
  has_many :langs
end
