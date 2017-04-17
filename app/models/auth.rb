class Auth < ApplicationRecord
  belongs_to :authable, polymorphic: true
  validates :provider, :uid, :presence => true

  def self.find_or_create(auth_hash)
    unless auth = find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      employee = Employee.create(
        :name => auth_hash["info"]["name"],
        :email => auth_hash["info"]["email"],
        :first_name => auth_hash["info"]["first_name"],
        :last_name => auth_hash["info"]["last_name"],
        :pic_sm => auth_hash["info"]["image"]
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
