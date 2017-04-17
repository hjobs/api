class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.integer :name
      t.integer :value
      t.belongs_to :ratable, polymorphic: true

      t.timestamps
    end
  end
end
