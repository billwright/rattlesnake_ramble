class RacersController < ApplicationController

  def index
    @racers = Racer.all
  end
  
  def show
    @racer = Racer.find(params[:id])
    # binding.pry
  end
  
  def new
    @racer = Racer.new
  end
  
  def create
    # binding.pry
    @racer = Racer.new(recipe_params)
    
    if @racer.save
      flash[:success] = "Your racer was created successfully!"
      redirect_to racers_path
    else
      render :new
    end
  end
  
  private
  
    def recipe_params
      params.require(:racer).permit(:first_name, :last_name, :email, :gender, :birth_date, :city, :state)
    end
end