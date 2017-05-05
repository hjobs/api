class ModifyLang < ActiveRecord::Migration[5.0]
  def change
    add_column :langs, :native_name, :string
    add_column :langs, :code, :string
  end
end
