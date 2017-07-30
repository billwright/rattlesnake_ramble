require 'chronic_duration'

class RaceEntry < ActiveRecord::Base
  
  def elapsed_time
    return ChronicDuration.output(@time)
  end
  
  def set_elapsed_time(time_string)
    @time = ChronicDuration.parse(time_string)
  end
  
end