class Auth < ApplicationRecord
  belongs_to :authable, polymorphic: true
  validates :provider, :uid, :presence => true

  def self.find_or_create(auth_hash)
    unless auth = find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      employee = Employee.create(
        :name => auth_hash["info"]["name"],
        :email => auth_hash["info"]["email"]
      )
      auth = create(
        :authable => employee,
        :provider => auth_hash["provider"],
        :uid => auth_hash["uid"]
      )
    end

    auth
  end

end
