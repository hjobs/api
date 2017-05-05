class CreateProfileViewers < ActiveRecord::Migration[5.0]
  def change
    create_table :profile_viewers do |t|
      t.belongs_to :org, foreign_key: true
      t.belongs_to :employee, foreign_key: true

      t.timestamps
    end
  end
end
