class CreateAuths < ActiveRecord::Migration[5.0]
  def change
    create_table :auths do |t|
      t.string :provider
      t.string :uid
      t.belongs_to :authable, polymorphic: true

      t.timestamps
    end
  end
end
