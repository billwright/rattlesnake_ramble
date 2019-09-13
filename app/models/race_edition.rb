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

  def male_offset_minutes
    male_offset / 60.0
  end

  def male_offset_minutes=(minutes)
    return unless minutes.present?

    self.male_offset = minutes.to_f * 60
  end

  def female_offset_minutes
    female_offset / 60.0
  end

  def female_offset_minutes=(minutes)
    return unless minutes.present?

    self.female_offset = minutes.to_f * 60
  end
end
