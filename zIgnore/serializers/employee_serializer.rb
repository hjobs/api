class EmployeeSerializer < ActiveModel::Serializer
  attributes :id, :email, :password, :name, :description, :country
end
