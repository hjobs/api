class EmployerSerializer < ActiveModel::Serializer
  attributes :id, :email, :password, :name, :description
  has_one :org
end
