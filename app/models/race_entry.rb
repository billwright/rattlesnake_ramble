require 'chronic_duration'

class RaceEntry < ActiveRecord::Base
  belongs_to :racer
  belongs_to :race_edition
     
  validates :racer, presence: true
  validates :race_edition, presence: true

  after_initialize :default_values
  
  def default_values
    self.paid = false if self.paid.nil?
  end
  
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