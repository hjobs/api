class AddFieldsToEmployees < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :image, :string
    add_column :employees, :phone, :string
    remove_column :employees, :pic_sm, :string
    remove_column :employees, :pic_hd, :string
  end
end
