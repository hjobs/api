class CreateJobLangs < ActiveRecord::Migration[5.0]
  def change
    create_table :job_langs do |t|
      t.belongs_to :job, foreign_key: true
      t.belongs_to :lang, foreign_key: true

      t.timestamps
    end
  end
end
