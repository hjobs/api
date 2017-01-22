class OrgJobSerializer < ActiveModel::Serializer
  attributes :id
  has_one :org
  has_one :job
end
