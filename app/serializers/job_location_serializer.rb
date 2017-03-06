class JobLocationSerializer < ActiveModel::Serializer
  attributes :id
  has_one :job
  has_one :location
end
