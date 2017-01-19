class ChangeDeadlineColumnType < ActiveRecord::Migration[5.0]
  def change
    change_column(:projects, :deadline, :datetime)
    change_column(:jobs, :deadline, :datetime)
  end
end
