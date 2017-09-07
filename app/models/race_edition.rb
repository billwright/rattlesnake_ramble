class RaceEdition < ActiveRecord::Base
  extend FriendlyId

  belongs_to :race
  has_many :race_entries, dependent: :destroy
  has_many :racers, through: :race_entries

  accepts_nested_attributes_for :racers
  friendly_id :name, use: :slugged

  validates :race_id, presence: true
  validates :date, presence: true
  validates :entry_fee, presence: true
  validates_uniqueness_of :race_id, scope: :date

  def name
    "#{race&.name} on #{date}"
  end
end