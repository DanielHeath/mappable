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
    @map.current_turn += 1
    @map.save!
    redirect_to @map
  end
  
  def new_from_rpol
    # Basically just a dumb template.
    @map = Map.new
  end
  
  def create_from_rpol
    # Real code is commented out. Mock code below lets me work on the views.
    @map = Map.create!(:name => "New " + rand().to_s[0..5], :image_filename => 'map.jpg')
    @entities = RPOLScraper.scrape_game_characters(@map, 7303).flatten
#    @map = Map.new(:name => params[:map_name], :image_filename => params[:image])
#    if @map.set_game_id_from_url(params[:game_url])
#    @entities = RPOLScraper.scrape_game_characters(@map, 7303).flatten
#    end
  end
  
end
