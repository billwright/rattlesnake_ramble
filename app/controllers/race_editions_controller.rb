class RaceEditionsController < ApplicationController
  before_action :set_race_edition, except: [:index, :new, :create]

  def index
    @race_edition = RaceEdition.all
  end

  def show
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
  end

  def update
    if @race_edition.update(obj_params)
      flash[:success] = "Your race edition was updated successfully"
      redirect_to race_edition_path(@race_edition)
    end
  end

  def enter
    @racer = Racer.new
  end

  def create_entry
    @racer = Racer.new(obj_params[:racers_attributes]['0'])

    if @racer.save
      @race_edition.racers << @racer
      flash[:success] = "Thank you for entering #{@race_edition.name}"
      redirect_to race_edition_path(@race_edition)
    else
      render 'enter'
    end
  end


  private

  def obj_params
    params.require(:race_edition)
        .permit(:date, racers_attributes: [:id, :first_name, :last_name, :email, :gender, :birth_date, :city, :state])
  end

  def set_race_edition
    @race_edition = RaceEdition.find(params[:id])
  end

end