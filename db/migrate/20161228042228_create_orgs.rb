class CreateOrgs < ActiveRecord::Migration[5.0]
  def change
    create_table :orgs do |t|
      t.string :name
      t.text :description
      t.string :country
      t.string :region
      t.text :address
      t.string :logo

      t.timestamps
    end
  end
end
