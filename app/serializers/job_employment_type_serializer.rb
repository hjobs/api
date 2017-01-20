class JobEmploymentTypeSerializer < ActiveModel::Serializer
  attributes :id
  has_one :job
  has_one :employment_type
end
