class AddEmailToOrganisation < ActiveRecord::Migration[5.0]
  def change
    add_column :organisations, :email, :string
    add_index :organisations, :email
  end
end
