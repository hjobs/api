class ChangeRewardMoneyToRewardValue < ActiveRecord::Migration[5.0]
  def change
    rename_column :projects, :reward_money, :reward_value
    change_column :projects, :reward_value, :text
  end
end
