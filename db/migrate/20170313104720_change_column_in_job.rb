class ChangeColumnInJob < ActiveRecord::Migration[5.0]
  def change
    change_column :jobs, :salary_value, :text
  end
end
