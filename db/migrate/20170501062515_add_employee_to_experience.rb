class AddEmployeeToExperience < ActiveRecord::Migration[5.0]
  def change
    add_reference :experiences, :employee, foreign_key: true
  end
end
