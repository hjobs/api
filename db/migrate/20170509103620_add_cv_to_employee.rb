class AddCvToEmployee < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :cv, :string
  end
end
