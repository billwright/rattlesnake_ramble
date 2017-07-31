class RacersController < ApplicationController

  def index
    @racers = Racer.all
  end
  
  def show
    @racer = Racer.find(params[:id])
    # binding.pry
  end
  
end