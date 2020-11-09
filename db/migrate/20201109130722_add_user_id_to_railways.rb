class AddUserIdToRailways < ActiveRecord::Migration[6.0]
  def change
    add_column :railways, :user_id, :integer
  end
end
