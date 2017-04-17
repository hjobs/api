class DeleteColumnsFromEmployee < ActiveRecord::Migration[5.0]
  def change
    remove_column :employees, :provider, :string
    remove_column :employees, :uid, :string
    remove_column :employees, :password_digest, :string
    remove_column :employees, :country, :string
  end
end
