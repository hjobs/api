class JobPeriodSerializer < ActiveModel::Serializer
  attributes :id
  has_one :job
  has_one :period
end
