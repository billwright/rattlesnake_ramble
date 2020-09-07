class RacersController < ApplicationController
  before_action :authenticate_user!

  def index
    @racers = Racer.all
  end

  def show
    @racer = Racer.find(params[:id])
  end

  def new
    @racer = Racer.new
  end

  def create
    @racer = Racer.new(obj_params)

    if @racer.save
      flash[:success] = "Your racer was created successfully!"
      redirect_to racers_path
    else
      render :new
    end
  end

  def edit
    @racer = Racer.find(params[:id])
  end

  def update
    @racer = Racer.find(params[:id])
    if @racer.update(obj_params)
      flash[:success] = "Your racer was updated successfully"
      redirect_to racer_path(@racer)
    end
  end

  private

  def obj_params
    params.require(:racer).permit(:first_name, :last_name, :email, :gender, :birth_date, :city, :state)
  end
end
