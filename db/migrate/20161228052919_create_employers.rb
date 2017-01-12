class CreateEmployers < ActiveRecord::Migration[5.0]
  def change
    create_table :employers do |t|
      t.string :email
      t.string :password
      t.string :name
      t.string :description
      t.belongs_to :org, foreign_key: true

      t.timestamps
    end
  end
end
