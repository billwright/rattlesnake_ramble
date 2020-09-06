class RaceEdition < ActiveRecord::Base
  extend FriendlyId
  include TimeZonable

  belongs_to :race
  has_many :race_entries, dependent: :destroy
  has_many :racers, through: :race_entries

  zonable_attributes :default_start_time_female, :default_start_time_male

  accepts_nested_attributes_for :racers
  friendly_id :name, use: :slugged

  validates :race_id, presence: true
  validates :date, presence: true
  validates :entry_fee, presence: true
  validates_uniqueness_of :race_id, scope: :date

  def name
    "#{race&.name} on #{date}"
  end

  def home_time_zone
    ::RambleConfig.home_time_zone
  end
end
