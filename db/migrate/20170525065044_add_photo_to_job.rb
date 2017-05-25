class AddPhotoToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :photo, :string
  end
end
