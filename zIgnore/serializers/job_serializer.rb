class JobSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :deadline, :salary_type, :salary_value, :salary_high, :salary_low, :salary_unit, :position
end
