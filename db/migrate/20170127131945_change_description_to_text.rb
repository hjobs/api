class ChangeDescriptionToText < ActiveRecord::Migration[5.0]
  def change
    change_column :employers, :description, :text
    change_column :employees, :description, :text
  end
end
