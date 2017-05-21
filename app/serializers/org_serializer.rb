class OrgSerializer < ActiveModel::Serializer
  attributes  :id,
              :email,
              :logo,
              :name

  has_many    :locations
end
