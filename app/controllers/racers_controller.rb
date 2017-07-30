class RacersController < ApplicationController

  def index
    @racers = Racer.all
  end
  
end