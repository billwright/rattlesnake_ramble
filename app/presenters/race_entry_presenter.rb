# frozen_string_literal: true

class RaceEntryPresenter < SimpleDelegator
  def scheduled_start_time_military
    I18n.localize(scheduled_start_time_local, format: :military) if scheduled_start_time_local.present?
  end
end
