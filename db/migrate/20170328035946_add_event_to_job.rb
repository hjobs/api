class AddEventToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :event, :string, :limit => 191
  end
end
