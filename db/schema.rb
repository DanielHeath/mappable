# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091215092705) do

  create_table "entities", :force => true do |t|
    t.integer  "map_id",                               :null => false
    t.integer  "user_id"
    t.string   "name",       :default => "New Object", :null => false
    t.integer  "pos_x",      :default => 1,            :null => false
    t.integer  "pos_y",      :default => 1,            :null => false
    t.integer  "size",       :default => 1,            :null => false
    t.integer  "speed",      :default => 6,            :null => false
    t.string   "image_url",  :default => "image.png",  :null => false
    t.boolean  "deadzone",   :default => false,        :null => false
    t.boolean  "locked",     :default => false,        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entities", ["map_id", "name"], :name => "index_entities_on_map_id_and_name", :unique => true
  add_index "entities", ["user_id"], :name => "index_entities_on_user_id"

  create_table "maps", :force => true do |t|
    t.string   "image_url",    :default => "map.jpg"
    t.string   "name",         :default => "Name of the map"
    t.integer  "width",        :default => 10
    t.integer  "height",       :default => 10
    t.integer  "current_turn", :default => 1
    t.integer  "x_offset",     :default => 0
    t.integer  "y_offset",     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "game_id"
    t.string   "user_id"
  end

  add_index "maps", ["name"], :name => "index_maps_on_name", :unique => true

  create_table "moves", :force => true do |t|
    t.integer  "entity_id"
    t.integer  "old_x"
    t.integer  "old_y"
    t.integer  "new_x"
    t.integer  "new_y"
    t.integer  "turn"
    t.string   "abilities"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "moves", ["entity_id", "created_at"], :name => "index_moves_on_entity_id_and_created_at"

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :null => false
    t.string  "server_url"
    t.string  "salt",       :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt",               :limit => 12
  end

end
