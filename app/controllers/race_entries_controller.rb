class RaceEntriesController < ApplicationController

  def index
    @race_entries = RaceEntry.all
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
      flash[:success] = "Your race edition was updated successfully"
      redirect_to race_entry_path(@race_entry)
    end
  end
  
  private
  
    def obj_params
      params.require(:race_entry).permit(:racer_id, :race_edition_id, :time)
    end
end