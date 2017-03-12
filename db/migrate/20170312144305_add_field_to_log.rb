class AddFieldToLog < ActiveRecord::Migration[5.0]
  def change
    add_reference :logs, :job_type, foreign_key: true
    add_column :logs, :component, :string, :limit => 191
    add_column :logs, :page, :string, :limit => 191
  end
end
