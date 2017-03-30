class DropEmployeeProject < ActiveRecord::Migration[5.0]
  def change
    drop_table :employee_projects
  end
end
