class EmployeeSerializer < ActiveModel::Serializer
  attributes :id,
              :email,
              :name,
              :description,
              :first_name,
              :last_name,
              :image,
              :phone,
              :auth_token

  has_many :jobs
  has_many :ratings
  has_many :scores

  def auth_token
    return @instance_options[:auth_token] || nil
  end
end
