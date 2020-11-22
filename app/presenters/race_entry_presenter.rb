# frozen_string_literal: true

class RaceEntryPresenter < SimpleDelegator
  def elapsed_time_na_if_nil
    elapsed_time || "NA"
  end

  def scheduled_start_time_military
    I18n.localize(scheduled_start_time_local, format: :military) if scheduled_start_time_local.present?
  end
end
