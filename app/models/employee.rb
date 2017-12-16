class Employee < ApplicationRecord
  has_secure_password :validations => false
  belongs_to :location, :optional => true
  has_many :auths, as: :authable, dependent: :destroy
  has_many :employee_jobs, dependent: :destroy
  has_many :jobs, through: :employee_jobs
  has_many :experiences
  has_many :lang_qs, :dependent => :destroy
  has_many :langs, through: :lang_qs
  has_many :job_exps, :dependent => :nullify

  has_many :ratings, as: :ratable, dependent: :destroy
  has_many :scores, as: :scorable, dependent: :destroy

  has_many :logs, dependent: :nullify

  accepts_nested_attributes_for :location

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

  def self.create_from_auth_hash(auth_hash)
    image = auth_hash["info"]["image"] || (
      "https://dummyimage.com/250/EEE/111.png?text=" + (
        auth_hash["info"]["first_name"] || auth_hash["info"]["name"]
      )
    )
    e = create(
      :name => auth_hash["info"]["name"],
      :email => auth_hash["info"]["email"],
      :first_name => auth_hash["info"]["first_name"],
      :last_name => auth_hash["info"]["last_name"],
      :image => image,
      :phone => auth_hash["info"]["phone"]
    )
  end

end
