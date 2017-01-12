class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.integer :deadline
      t.string :salary_type
      t.integer :salary_value
      t.integer :salary_high
      t.integer :salary_low
      t.string :salary_unit
      t.string :position

      t.timestamps
    end
  end
end
