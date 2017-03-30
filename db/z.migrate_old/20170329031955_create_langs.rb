class CreateLangs < ActiveRecord::Migration[5.0]
  def change
    create_table :langs do |t|
      t.string :name, :limit => 191
      t.string :country, :limit => 191

      t.timestamps
    end
  end
end
