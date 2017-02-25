class DropEmployerProject < ActiveRecord::Migration[5.0]
  def change
    drop_table :employer_projects
  end
end
