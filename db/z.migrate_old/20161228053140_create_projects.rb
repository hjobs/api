class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.integer :start_date
      t.integer :end_date
      t.integer :deadline
      t.string :reward_type
      t.integer :reward_money
      t.string :reward_other

      t.timestamps
    end
  end
end
