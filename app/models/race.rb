class Race < ActiveRecord::Base
  extend FriendlyId

  has_many :race_editions
  validates :name, presence: true, length: { minimum: 5, maximum: 100 }
  validates_uniqueness_of :name, case_sensitive: false
  friendly_id :name, use: :slugged
end