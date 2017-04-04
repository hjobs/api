class CreateAds < ActiveRecord::Migration[5.0]
  def change
    create_table :ads do |t|
      t.string :link, :limit => 191
      t.string :image, :limit => 191
      t.string :title, :limit => 191
      t.text :description
      t.belongs_to :org, foreign_key: true
      t.belongs_to :employer, foreign_key: true

      t.timestamps
    end
  end
end
