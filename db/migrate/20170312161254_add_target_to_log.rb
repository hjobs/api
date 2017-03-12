class AddTargetToLog < ActiveRecord::Migration[5.0]
  def change
    add_column :logs, :target, :string, :limit => 191
  end
end
