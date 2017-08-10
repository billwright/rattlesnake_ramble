class RaceEditionsController < ApplicationController

  def index
    @race_edition = RaceEdition.all
  end
  
  def show
    @race_edition = RaceEdition.find(params[:id])
    # binding.pry
  end
  
  def new
    @race_edition = RaceEdition.new
  end
  
  def create
    # binding.pry
    @race_edition = RaceEdition.new(obj_params)
    
    if @race_edition.save
      flash[:success] = "Your race edition was created successfully!"
      redirect_to race_editions_path
    else
      render :new
    end
  end
  
  def edit
    @race_edition = RaceEdition.find(params[:id])
  end
  
  def update
    @race_edition = RaceEdition.find(params[:id])
    if @race_edition.update(obj_params)
      flash[:success] = "Your race edition was updated successfully"
      redirect_to race_edition_path(@race_edition)
    end
  end
  
  def enter
    Rails.logger.debug "In enter method of RaceEditionsController"
    
    @race_edition = RaceEdition.find(params[:id])
    @race_entry = RaceEntry.new
    @race_entry.racer = Racer.new
    @race_edition.race_entries << @race_entry
  end
  
  
  private
  
    def obj_params
      params.require(:race_edition).permit(:date)
    end
end