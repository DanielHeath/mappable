class MovesController < ApplicationController
  def create
    @entity = Entity.find(params[:move][:entity_id], :include => :map)
    raise "You are not authorized to move this entity" unless (@entity.user == current_user) || (@entity.map.user == current_user) || (!@entity.user)
      
    @move = Move.new(params[:move])
    @move.turn = @entity.map.current_turn
    @entity.apply_move(@move)
    @entity.transaction do
      @move.save!
      @entity.save!
    end
    render :json => @entity.to_json
  end
end
