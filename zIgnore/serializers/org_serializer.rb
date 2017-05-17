class OrgSerializer < ActiveModel::Serializer
  attributes  :id,
              :name,
              :description,
              :country,
              :region,
              :address,
              :logo
  
end
