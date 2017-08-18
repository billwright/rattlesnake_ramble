require 'chronic_duration'

class RaceEntry < ActiveRecord::Base
  belongs_to :racer
  belongs_to :race_edition

  validates :racer, presence: true
  validates :race_edition, presence: true
  validates_uniqueness_of :racer_id, scope: :race_edition_id,
                          message: 'may be added to a race_edition only once'

  after_initialize :default_values

  def default_values
    self.paid = false if self.paid.nil?
  end

  def elapsed_time
    time && ChronicDuration.output(time) || 'NA'
  end

  def elapsed_time=(time_string)
    time_string ||= ''
    self.time = ChronicDuration.parse(time_string)
  end

  def name
    "#{racer.name}'s entry into #{race_edition.name}"
  end
end