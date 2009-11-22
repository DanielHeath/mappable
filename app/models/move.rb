class Move < ActiveRecord::Base
  belongs_to :entity
  validates_presence_of :movement_used, :in => (0..(1.5))
  
  def movement_used
    dx = (new_x - old_x).abs
    dy = (new_y - old_y).abs
    (dx**2 + dy**2)**(0.5)
  end
end
