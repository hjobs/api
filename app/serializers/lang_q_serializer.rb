class EmployeeSerializer < ActiveModel::Serializer
  attributes  :language,
              :level
              

  has_one :employee

  def language
    object.lang&.name || nil if !!object
    nil
  end

end
