class AddColToEmployee < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :provider, :string
    add_column :employees, :uid, :string
    add_column :employees, :pic_hd, :string
    add_column :employees, :pic_sm, :string
    add_column :employees, :first_name, :string
    add_column :employees, :last_name, :string
  end
end
