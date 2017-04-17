class ScoreSerializer < ActiveModel::Serializer
  attributes :id, :name, :value
  has_one :scorable
end
