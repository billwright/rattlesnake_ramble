class AddUniqueIndexToRaceEntries < ActiveRecord::Migration[5.1]
  def change
    add_index :race_entries,
              [:racer_id, :race_edition_id],
              unique: true
  end
end
