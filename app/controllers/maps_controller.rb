class MapsController < ApplicationController
  # Tests: Only for actions of 3+ lines.
  layout 'show_map', :only => :show

  def index
    @map = Map.new
    @maps = Map.find_by_sql ["
      SELECT m.* 
      FROM maps m
      LEFT OUTER JOIN entities e
      ON e.map_id = m.id
      WHERE e.user_id = ?
      OR m.user_id = ?
      GROUP BY m.id", current_user.id, current_user.id]
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
    @map.user = current_user
    if @map.save
      if @map.game_id
        @entities = RPOLScraper.scrape_game_characters(@map, @map.game_id).flatten
      end
      redirect_to(@map) 
    else
      render(:new)
    end
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

  # The following all need tests written!
  def clone
    @map = Map.find(params[:id])
    @new_map = Map.new(@map.attributes)
    @new_map.name += ' clone'
    @new_map.save!
    redirect_to @new_map
  end

  def next_turn
    @map = Map.find(params[:id])
    raise "Only the map owner may use the next turn button." unless @map.gm_is(current_user)
    @map.current_turn += 1
    @map.save!
    redirect_to @map
  end
  
end
