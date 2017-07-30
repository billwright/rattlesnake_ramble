class Race < ActiveRecord::Base
  has_many :race_editions
  validates :name, presence: true, length: { minimum: 5, maximum: 100 }
end