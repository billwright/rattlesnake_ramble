class RaceEntriesController < ApplicationController

  def index
    sort = params[:sort] || 'racers.last_name'
    @race_entries = RaceEntry.includes(:racer, :race_edition).order(sort)
  end
  
  def show
    @race_entry = RaceEntry.find(params[:id])
    # binding.pry
  end
  
  def new
    @race_entry = RaceEntry.new
  end
  
  def create
    # binding.pry
    @race_entry = RaceEntry.new(obj_params)
    
    if @race_entry.save
      flash[:success] = "Your entry was created successfully!"
      redirect_to race_entries_path
    else
      render :new
    end
  end
  
  def edit
    @race_entry = RaceEntry.find(params[:id])
  end
  
  def update
    @race_entry = RaceEntry.find(params[:id])
    if @race_entry.update(obj_params)
      flash[:success] = "Your race entry was updated successfully"
      redirect_to race_entries_path
    end
  end

  def destroy
    @race_entry = RaceEntry.find(params[:id])
    if @race_entry.destroy
      flash[:success] = "Your race entry was deleted"
      redirect_to race_entries_path
    end
  end
  
  def successful_entry
    race_entry = RaceEntry.find(params[:id])
    race_entry.paid = true
    if race_entry.save
       flash[:success] = "Get ready to Ramble, because you are entered!"
       redirect_to race_edition_path(race_entry.race_edition)
    end
  end
  
  def cancelled_payment
    race_entry = RaceEntry.find(params[:id])
    flash[:success] = "Until you pay, you are not officially in the Rattlesnake Ramble. Please pay via PayPal prmoptly or contact the race director (bwright@rattlesnakeramble.org)."
    redirect_to race_edition_path(race_entry.race_edition)
  end
  
  private
  
    def obj_params
      params.require(:race_entry).permit(:racer, :race_edition, :paid, :time, :bib_number)
    end
end