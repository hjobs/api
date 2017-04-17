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
              :pic_sm
  has_many :jobs
  has_many :ratings
  has_many :scores
end
