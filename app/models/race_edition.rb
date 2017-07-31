class RaceEdition < ActiveRecord::Base
   belongs_to :race
   has_many :race_entries

   validates :race_id, presence: true
   validates :date, presence: true
 end