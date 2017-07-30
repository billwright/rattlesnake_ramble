require 'chronic_duration'

class RaceEntry < ActiveRecord::Base
  belongs_to :racer
  belongs_to :race_edition
     
  validates :racer, presence: true
  validates :race_edition, presence: true


  def elapsed_time
    return ChronicDuration.output(@time)
  end
  
  def set_elapsed_time(time_string)
    @time = ChronicDuration.parse(time_string)
  end
  
end