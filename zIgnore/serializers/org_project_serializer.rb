class OrgProjectSerializer < ActiveModel::Serializer
  attributes :id
  has_one :org
  has_one :project
end
