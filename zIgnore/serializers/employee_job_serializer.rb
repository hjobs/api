class EmployeeJobSerializer < ActiveModel::Serializer
  attributes :id, :status, :message
  has_one :job
  has_one :employee
end
