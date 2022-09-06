class PagesController < ApplicationController
  include RaceReportsHelper

  def enter
  end

  def home
  end

  def race_reports
    year = params[:year]
    # Return 404 if the report year doesn't exist
    raise ::ActiveRecord::RecordNotFound unless year.in?(available_race_reports)

    render "pages/race_reports/#{year}"
  end
end
