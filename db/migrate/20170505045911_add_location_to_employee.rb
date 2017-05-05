class AddLocationToEmployee < ActiveRecord::Migration[5.0]
  def change
    add_reference :employees, :location, foreign_key: true
  end
end
