# frozen_string_literal: true

class RaceEditionsController < ApplicationController
  before_action :set_race_edition, except: [:index, :new, :create]

  def show
    race_edition = RaceEdition.where(id: @race_edition).includes(:race, race_entries: :racer).first
    @presenter = RaceEditionPresenter.new(race_edition, params)
  end

  def new
    @race_edition = RaceEdition.new(obj_params)
  end

  def create
    @race_edition = RaceEdition.new(obj_params)

    if @race_edition.save
      flash[:success] = "Your race edition was created successfully!"
      redirect_to race_edition_path(@race_edition)
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
    else
      render :edit
    end
  end

  def destroy
    if @race_edition.destroy
      flash[:success] = "Your race edition was deleted"
      redirect_to races_path
    end
  end

  def enter
    @racer = Racer.new
  end

  def create_entry
    @racer = Racer.new(obj_params[:racers_attributes]['0'])

    if @racer.save
      race_entry = RaceEntry.create(race_edition: @race_edition, racer: @racer)
      flash[:success] = "Thank you for entering #{@race_edition.name}"
      redirect_to paypal_url(race_entry)
    else
      render 'enter'
    end
  end

  def paypal_url(race_entry)
    item_number = "RaceEdition#{@race_edition.id}-Racer#{race_entry.racer.id}"
    values = {
        business: "bwright@rattlesnakeramble.org",
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{successful_entry_race_entry_path(race_entry)}",
        cancel_return: "#{Rails.application.secrets.app_host}#{cancelled_payment_race_entry_path(race_entry)}",
        invoice: "RaceEntry#{race_entry.id}",
        amount: @race_edition.entry_fee,
        item_name: @race_edition.name,
        item_number: item_number,
        quantity: '1',
        shipping: 0,
        handling: 0,
        no_shipping: 1,
        no_note: 1,
    }

    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query

  end
  
  helper_method :paypal_url

  def racer_emails
    all_entries = @race_edition.race_entries.eager_load(:racer)
    paid_filter = params[:filter] && (params[:filter][:paid] == 'true')
    filtered_entries = paid_filter.nil? ? all_entries : all_entries.where(paid: paid_filter)
    @racers = filtered_entries.map(&:racer)
  end

  def racer_info_csv
  end
  
  private

  def obj_params
    params.require(:race_edition)
        .permit(:race_id, :date, :entry_fee, :default_start_time_male_local, :default_start_time_female_local,
                racers_attributes: [:id, :first_name, :last_name, :email, :gender, :birth_date, :city, :state])
  end

  def set_race_edition
    @race_edition = RaceEdition.friendly.find(params[:id])
  end
end
