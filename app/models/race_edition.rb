class RaceEdition < ActiveRecord::Base
  belongs_to :race
  has_many :race_entries
  has_many :racers, through: :race_entries

  accepts_nested_attributes_for :racers

  validates :race_id, presence: true
  validates :date, presence: true

  def name
    race.name + ':' + date.to_s
  end

end