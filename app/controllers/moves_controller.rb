class MovesController < ApplicationController
  def create
    @entity = Entity.find(params[:move][:entity_id], :include => :map)
    @move = Move.new(params[:move])
    @move.turn = @entity.map.current_turn
    @entity.apply_move(@move)
    @entity.transaction do
      @move.save!
      @entity.save!
    end
    render :text => "success"
  end
end
