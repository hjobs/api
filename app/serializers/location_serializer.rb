class LocationSerializer < ActiveModel::Serializer
  attributes :id, :country, :region, :city, :district, :address
end
