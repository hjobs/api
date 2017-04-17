class Employee < ApplicationRecord
  has_many :auths, as: :authable, dependent: :destroy
  has_many :employee_jobs
  has_many :jobs, through: :employee_jobs

  has_many :ratings, as: :ratable, dependent: :destroy
  has_many :scores, as: :scorable, dependent: :destroy

  has_many :logs

  validates :name, :email, :presence => true

  def add_provider(auth_hash)
    # Check if the provider already exists, so we don't add it twice
    unless Auth.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      Auth.create(
        :authable => self,
        :provider => auth_hash["provider"],
        :uid => auth_hash["uid"]
      )
    end
  end

end
