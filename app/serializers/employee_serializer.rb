class EmployeeSerializer < ActiveModel::Serializer
  attributes  :id,
              :email,
              :name,
              :description,
              :first_name,
              :last_name,
              :image,
              :cv,
              :phone,
              :auth_token

  has_many :jobs
  has_many :job_exps
  has_many :ratings
  has_many :scores
  has_many :lang_qs
  has_one :location

  def auth_token
    return @instance_options[:auth_token] || nil
  end
end
