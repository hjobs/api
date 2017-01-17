class ChangeDataTypeOfReward < ActiveRecord::Migration[5.0]
  def change
    change_column(:jobs, :salary_value, :string)
    change_column(:projects, :reward_money, :string)
  end
end
