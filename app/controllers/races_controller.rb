class RacesController < ApplicationController
  before_action :set_race, except: [:index, :new, :create]

  def index
    @races = Race.all
  end

  def show
  end

  def new
    @race = Race.new
  end

  def create
    @race = Race.new(obj_params)

    if @race.save
      flash[:success] = "Your race was created successfully!"
      redirect_to races_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @race.update(obj_params)
      flash[:success] = "Your race was updated successfully"
      redirect_to race_path(@race)
    end
  end

  private

  def obj_params
    params.require(:race).permit(:name, :description)
  end

  def set_race
    @race = Race.friendly.find(params[:id])
  end
end