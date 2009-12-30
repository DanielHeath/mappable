class EntitiesController < ApplicationController
  before_filter :load_map
  
  def new
    @entity = Entity.new(params[:entity])
  end

  def create
    @entity = Entity.new(params[:entity])
    @entity.user = current_user
    @entity.save ? redirect_to(@map) : render(:new)
  end

  def edit
    @entity = Entity.find(params[:id])
  end

  def update
    @entity = Entity.find(params[:id])
    @entity.update_attributes(params[:entity])
  end
  
protected
  
  def load_map
    @map = Map.find(params[:map_id])
  end
  
end
