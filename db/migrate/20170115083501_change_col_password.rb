class ChangeColPassword < ActiveRecord::Migration[5.0]
  def change
    rename_column :employees, :password, :password_digest
    rename_column :employers, :password, :password_digest
  end
end
