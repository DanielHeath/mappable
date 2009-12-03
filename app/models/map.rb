class Map < ActiveRecord::Base
  validates_uniqueness_of :name
  has_many :entities
  
  def set_game_id_from_url(url)
    # Parses the url looking for /[&?]gi=\d+/ and save the result into game_id
  end
end
