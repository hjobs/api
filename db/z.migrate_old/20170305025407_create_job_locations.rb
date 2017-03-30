class CreateJobLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :job_locations do |t|
      t.belongs_to :job, foreign_key: true
      t.belongs_to :location, foreign_key: true

      t.timestamps
    end
  end
end
