class RemoveNameFromRailways < ActiveRecord::Migration[6.0]
  def change
    remove_column :railways, :name, :string
  end
end
