class RacerEditionsController < ApplicationController

  def index
    @race_edition_editions = RaceEdition.all
  end
  
  def show
    @race_edition = Raceedition.find(params[:id])
    # binding.pry
  end
  
  def new
    @race_edition = RaceEdition.new
  end
  
  def create
    # binding.pry
    @race_edition = RaceEdition.new(obj_params)
    
    if @race_edition.save
      flash[:success] = "Your racer was created successfully!"
      redirect_to racer_editions_path
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
      redirect_to racer_path(@race_edition)
    end
  end
  
  private
  
    def obj_params
      params.require(:racer).permit(:date)
    end
end