class AdSerializer < ActiveModel::Serializer
  attributes :id, :link, :image, :title, :description
  has_one :org
  has_one :employer
end
