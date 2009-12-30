class RenderRemoteImages < ActiveRecord::Migration
  def self.up
    rename_column :maps, :image_filename, :image_url
    rename_column :entities, :image_filename, :image_url
  end

  def self.down
    rename_column :maps, :image_url, :image_filename
    rename_column :entities, :image_url, :image_filename
  end
end
