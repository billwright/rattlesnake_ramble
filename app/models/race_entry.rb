require 'chronic_duration'

class RaceEntry < ActiveRecord::Base
  belongs_to :racer
  belongs_to :race_edition

  validates :racer, presence: true
  validates :race_edition, presence: true
  validates_uniqueness_of :racer_id, scope: :race_edition_id,
                          message: 'may be added to a race_edition only once'

  def elapsed_time
    time && ChronicDuration.output(time) || 'NA'
  end

  def elapsed_time=(time_string)
    time_string ||= ''
    self.time = ChronicDuration.parse(time_string)
  end
  
  def paypal_url(return_path, entry_fee, race_edition, racer)
    values = {
        business: "bwright-facilitator@rattlesnakeramble.org",
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{return_path}",
        invoice: id,
        amount: race_edition.entry_fee,
        item_name: race_edition.name,
        item_number: racer.id,
        quantity: '1'
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end
  
end