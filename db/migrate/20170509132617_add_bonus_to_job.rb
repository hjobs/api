class AddBonusToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :has_bonus, :boolean
    add_column :jobs, :bonus_value, :string
  end
end
