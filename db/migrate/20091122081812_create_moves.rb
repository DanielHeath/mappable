class CreateMoves < ActiveRecord::Migration
  def self.up
    create_table :moves do |t|
      t.integer :entity_id
      t.integer :old_x
      t.integer :old_y
      t.integer :new_x
      t.integer :new_y
      t.integer :turn
      t.string :abilities
      t.timestamps
    end
    add_index :moves, [:entity_id, :created_at]
  end

  def self.down
    drop_table :moves
  end
end
