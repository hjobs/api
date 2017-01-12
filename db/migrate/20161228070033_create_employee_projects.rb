class CreateEmployeeProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_projects do |t|
      t.string :status
      t.text :message
      t.belongs_to :project, foreign_key: true
      t.belongs_to :employee, foreign_key: true

      t.timestamps
    end
  end
end
