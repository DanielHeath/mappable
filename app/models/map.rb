class Map < ActiveRecord::Base
  validates_uniqueness_of :name
  has_many :entities
end
