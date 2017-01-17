class AddAttachmentFields < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :attachment_url, :string
    add_column :projects, :attachment_url, :string
  end
end
