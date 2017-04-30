class Auth < ApplicationRecord
  belongs_to :authable, polymorphic: true
  validates :provider, :uid, :presence => true

  def self.find_or_create(auth_hash)
    unless auth = find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      unless employee = Employee.find_by_email(auth_hash["info"]["email"])
        employee = Employee.create_from_auth_hash(auth_hash)
      end
      auth = create(
        :authable => employee,
        :provider => auth_hash["provider"],
        :uid => auth_hash["uid"]
      )
    end

    auth
  end

end
