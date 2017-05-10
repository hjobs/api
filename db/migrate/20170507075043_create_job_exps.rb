class CreateJobExps < ActiveRecord::Migration[5.0]
  def change
    create_table :job_exps do |t|
      t.string :position
      t.text :description
      t.belongs_to :employee, foreign_key: true
      t.belongs_to :location, foreign_key: true
      t.boolean :working
      t.datetime :time_from
      t.datetime :time_to
      t.belongs_to :org, foreign_key: true
      t.string :company_name

      t.timestamps
    end
  end
end
