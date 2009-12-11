class AddGameIdToMaps < ActiveRecord::Migration
  def self.up
    add_column :maps, :game_id, :integer
  end

  def self.down
    remove_column :maps, :game_id, :integer
  end
end
