class CreateExperiences < ActiveRecord::Migration[5.0]
  def change
    create_table :experiences do |t|
      t.string :position
      t.text :description
      t.string :company_name
      t.references :org, foreign_key: true
      t.boolean :working
      t.date :time_start
      t.date :time_end
      t.belongs_to :location, foreign_key: true

      t.timestamps
    end
  end
end
