class OwnershipController < ApplicationController
  
  def map
    redirect_to take_over(Map, params)
  end
  
  def entity
    @entity = take_over(Entity, params)
    redirect_to @entity.map
  end
  
private

  def take_over(type, params)
    thing = type.find(params[:id])
    puts current_user.inspect
      puts "Secret key used: '#{params[:secret_key]}'"
      puts "Secret key needed: '#{thing.secret_key}'"

    if (thing.secret_key == params[:secret_key])
      thing.user = current_user
      thing.save!
      flash[:notice] = "You are now the owner of #{type.to_s.downcase}: #{thing.name}"
    else
      flash[:error] = "Incorrect secret key. Try getting the URL again."
    end
    thing
  end
  
end
