class CreateEmployerJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :employer_jobs do |t|
      t.belongs_to :employer, foreign_key: true
      t.belongs_to :job, foreign_key: true

      t.timestamps
    end
  end
end
