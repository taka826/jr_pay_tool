class CreateRailways < ActiveRecord::Migration[6.0]
  def change
    create_table :railways do |t|
      t.integer :junction_id, null: false
      t.integer :price, null: false
      t.integer :terminal_id, null: false
      t.timestamps
    end
  end
end
