class CreateScores < ActiveRecord::Migration[5.0]
  def change
    create_table :scores do |t|
      t.integer :name
      t.integer :value
      t.belongs_to :scorable, polymorphic: true

      t.timestamps
    end
  end
end
