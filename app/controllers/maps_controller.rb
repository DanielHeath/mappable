class MapsController < ApplicationController
  # Tests: Only for actions of 3+ lines.

  def index
    @map = Map.new
    @maps = Map.find :all
  end

  def show
    @map = Map.find(params[:id])
    @entity = Entity.new(params[:entity])
  end

  def new
    @map = Map.new(params[:map])
  end

  def create
    @map = Map.new(params[:map])
    @map.save ? redirect_to(@map) : render(:new)
  end

  def edit
    @map = Map.find(params[:id])
  end

  def update
    @map = Map.find(params[:id])
    @map.update_attributes(params[:map])
    redirect_to @map
  end
  
  def destroy
    Map.delete(params[:id])
    redirect_to :action => :index
  end

  # Needs tests!
  def clone
    @map = Map.find(params[:id])
    @new_map = Map.new(@map.attributes)
    @new_map.name += ' clone'
    @new_map.save!
    redirect_to @new_map
  end

  def next_turn
    @map = Map.find(params[:id])
    @map.current_turn += 1
    @map.save!
    redirect_to @map
  end
  
end
