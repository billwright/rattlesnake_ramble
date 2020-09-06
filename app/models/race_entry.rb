# frozen_string_literal: true

require 'chronic_duration'

class RaceEntry < ActiveRecord::Base
  include TimeZonable

  belongs_to :racer
  belongs_to :race_edition

  zonable_attribute :scheduled_start_time

  validates :racer, presence: true
  validates :race_edition, presence: true
  validates_uniqueness_of :racer_id, scope: :race_edition_id,
                          message: 'may be added to a race_edition only once'
  validates_uniqueness_of :bib_number, scope: :race_edition_id, allow_nil: true,
                          message: 'may not be duplicated within a race edition'

  after_initialize :default_values

  attr_accessor :category_name
  delegate :date, to: :race_edition

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

  def home_time_zone
    ::RambleConfig.home_time_zone
  end

  def name
    "#{racer.name}'s entry into #{race_edition.name}"
  end
end