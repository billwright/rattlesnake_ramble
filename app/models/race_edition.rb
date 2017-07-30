class RaceEdition < ActiveRecord::Base
   belongs_to :race
   validates :date, presence: true
 end