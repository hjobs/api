class AddAdToLog < ActiveRecord::Migration[5.0]
  def change
    add_reference :logs, :ad, foreign_key: true
  end
end
