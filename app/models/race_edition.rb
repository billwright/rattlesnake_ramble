class RaceEdition < ActiveRecord::Base
   belongs_to :race

   validates :race_id, presence: true
   validates :date, presence: true
 end