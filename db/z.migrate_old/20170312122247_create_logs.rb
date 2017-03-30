class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.string :name
      t.string :action
      t.belongs_to :job, foreign_key: true
      t.belongs_to :employee, foreign_key: true
      t.belongs_to :employer, foreign_key: true
      t.belongs_to :org, foreign_key: true

      t.timestamps
    end
  end
end
