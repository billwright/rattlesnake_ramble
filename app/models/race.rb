class Race < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 5, maximum: 100 }
end