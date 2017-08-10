require 'chronic_duration'

class RaceEntry < ActiveRecord::Base
  belongs_to :racer
  belongs_to :race_edition
     
  validates :racer, presence: true
  validates :race_edition, presence: true
  validates_uniqueness_of :racer_id, scope: :race_edition_id,
                          message: 'may be added to a race_edition only once'

  def elapsed_time
    if time? then
      ChronicDuration.output(time)
    else
      'NA'
    end
  end
  
  def set_elapsed_time(time_string)
    time = ChronicDuration.parse(time_string)
  end
  
end