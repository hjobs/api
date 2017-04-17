class RatingSerializer < ActiveModel::Serializer
  attributes :id, :name, :value
  has_one :ratable
end
