class CreateJobPeriods < ActiveRecord::Migration[5.0]
  def change
    create_table :job_periods do |t|
      t.belongs_to :job, foreign_key: true
      t.belongs_to :period, foreign_key: true

      t.timestamps
    end
  end
end
