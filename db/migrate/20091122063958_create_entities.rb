class CreateEntities < ActiveRecord::Migration
  def self.up
    create_table :entities do |t|
      t.integer :map_id, :null => false
      t.integer :user_id
      t.string :name, :null => false, :default => "New Object"
      t.integer :pos_x, :null => false, :default => 1
      t.integer :pos_y, :null => false, :default => 1
      t.integer :size, :null => false, :default => 1
      t.integer :speed, :null => false, :default => 6
      t.string :image_filename, :null => false, :default => 'image.png'
      t.boolean :deadzone, :null => false, :default => false
      t.boolean :locked, :null => false, :default => false
      t.timestamps
    end
    add_index(:entities, [:map_id, :name], :unique => true)
    add_index(:entities, :user_id)
  end

  def self.down
    drop_table :entities
  end
end
