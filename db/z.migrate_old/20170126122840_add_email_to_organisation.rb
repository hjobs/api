class AddEmailToOrganisation < ActiveRecord::Migration[5.0]
  def change
    add_column :orgs, :email, :string
    add_index :orgs, :email
  end
end
