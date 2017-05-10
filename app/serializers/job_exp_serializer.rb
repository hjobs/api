class JobExpSerializer < ActiveModel::Serializer
  attributes  :id,
              :created_at,
              :updated_at,
              :position,
              :time_from,
              :time_to,
              :description,
              :working,
              :company_name,
              :location

  has_one :org
  has_one :employee

  def location
    object.location&.address || nil
  end
end
