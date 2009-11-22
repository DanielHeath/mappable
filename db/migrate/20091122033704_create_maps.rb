class CreateMaps < ActiveRecord::Migration
  def self.up
    create_table :maps do |t|
      t.string :image_filename, :nil => false, :default => "map.jpg"
      t.string :name, :nil => false, :default => "Name of the map"
      t.integer :width, :nil => false, :default => 10
      t.integer :height, :nil => false, :default => 10
      t.integer :current_turn, :nil => false, :default => 1
      t.integer :x_offset, :nil => false, :default => 0
      t.integer :y_offset, :nil => false, :default => 0
      t.timestamps
    end
    add_index(:maps, [:name], :unique => true)
  end

  def self.down
    drop_table :maps
  end
end
