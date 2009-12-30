class LinkUsersToMaps < ActiveRecord::Migration
  def self.up
    add_column :maps, :user_id, :string
  end

  def self.down
    remove_column :maps, :user_id
  end
end
