class CreateJobEmploymentTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :job_employment_types do |t|
      t.belongs_to :job, foreign_key: true
      t.belongs_to :employment_type, foreign_key: true

      t.timestamps
    end
  end
end
