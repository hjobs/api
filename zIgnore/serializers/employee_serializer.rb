class EmployeeSerializer < ActiveModel::Serializer
  attributes :id,
              :email,
              :password,
              :name,
              :description,
              :country,
              :uid,
              :first_name,
              :last_name,
              :pic_hd,
              :pic_sm,
              :auth_token
  has_many :jobs
  has_many :ratings
  has_many :scores

  def auth_token
    return @instance_options[:auth_token] || nil
  end
end
