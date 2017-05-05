class ModifyLocation < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :lat, :decimal, {:precision=>10, :scale=>6}
    add_column :locations, :lng, :decimal, {:precision=>10, :scale=>6}
    add_column :locations, :street, :string
  end
end
