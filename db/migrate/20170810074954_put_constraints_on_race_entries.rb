class PutConstraintsOnRaceEntries < ActiveRecord::Migration[5.1]
  def change
    change_column_null :race_entries, :racer_id, false
    change_column_null :race_entries, :race_edition_id, false
    add_foreign_key :race_entries, :racers
    add_foreign_key :race_entries, :race_editions
  end
end
