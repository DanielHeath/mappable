class Entity < ActiveRecord::Base
  # I really hope nothing in AR uses instance.map (aka collect).
  # If I get wierd behavior, this might be one place to look.
  belongs_to :map
  has_many :moves
  
  def apply_move(move)
    raise "This move doesn't match the servers data (expected #{pos_x}, #{pos_y}, got #{move.old_x}, #{move.old_y})" unless (move.old_x == pos_x) and (move.old_y == pos_y)
    raise "You've moved too far this turn" unless (movement_used_this_turn + move.movement_used) <= speed
    self.pos_x = move.new_x
    self.pos_y = move.new_y
  end
  
  def movement_used_this_turn
    moves.find_all_by_turn(map.current_turn).collect(&:movement_used).sum.to_i
  end
  
end

