class ExperienceSerializer < ActiveModel::Serializer
  attributes  :id,
              :position,
              :description,
              :company_name,
              :working,
              :time_start,
              :time_end

  has_one :org
  has_one :location
  has_one :employees
end
