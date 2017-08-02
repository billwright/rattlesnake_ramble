class RacesController < ApplicationController

  def index
    @races = Race.all
  end
  
  def show
    @race = Race.find(params[:id])
    # binding.pry
  end
  
  def new
    @race = Race.new
  end
  
  def create
    # binding.pry
    @race = Race.new(obj_params)
    
    if @race.save
      flash[:success] = "Your race was created successfully!"
      redirect_to races_path
    else
      render :new
    end
  end
  
  def edit
    @race = Race.find(params[:id])
  end
  
  def update
    @race = Race.find(params[:id])
    if @race.update(obj_params)
      flash[:success] = "Your race was updated successfully"
      redirect_to race_path(@race)
    end
  end
  
  private
  
    def obj_params
      params.require(:race).permit(:name, :description)
    end
end