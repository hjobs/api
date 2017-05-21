class AddDefaultLocationToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :default_location, :boolean
  end
end
