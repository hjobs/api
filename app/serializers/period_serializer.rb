class PeriodSerializer < ActiveModel::Serializer
  attributes :id, :start_time, :end_time, :date
end
