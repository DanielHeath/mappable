class MapsController < ApplicationController
  # Tests: Only for actions of 3+ lines.

  def index
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
  end

  # Needs tests!
  def clone
    @map = Map.find(params[:id])
    @new_map = Map.new(@map.attributes)
    @new_map.name += ' clone'
    @new_map.save!
    redirect_to @new_map
  end

end
