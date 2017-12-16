class TagSerializer < ActiveModel::Serializer
  attributes  :group,
              :code,
              :id,
              :created_at
end