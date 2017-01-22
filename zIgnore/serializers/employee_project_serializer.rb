class EmployeeProjectSerializer < ActiveModel::Serializer
  attributes :id, :status, :message
  has_one :project
  has_one :employee
end
