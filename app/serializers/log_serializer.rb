class LogSerializer < ActiveModel::Serializer
  attributes :id, :name, :action, :page, :component, :target
  has_one :job
  has_one :employee
  has_one :employer
  has_one :org
  has_one :job_type
  has_one :ad
end
