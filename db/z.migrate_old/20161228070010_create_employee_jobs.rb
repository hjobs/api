class CreateEmployeeJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_jobs do |t|
      t.string :status
      t.text :message
      t.belongs_to :job, foreign_key: true
      t.belongs_to :employee, foreign_key: true

      t.timestamps
    end
  end
end
