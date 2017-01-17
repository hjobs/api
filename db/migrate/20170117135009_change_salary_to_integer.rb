class ChangeSalaryToInteger < ActiveRecord::Migration[5.0]
  def change
    change_column(:jobs, :salary_value, :int)
    change_column(:projects, :reward_money, :int)
  end
end
