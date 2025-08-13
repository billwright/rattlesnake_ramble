class AddAcceptingEntriesToRaceEditions < ActiveRecord::Migration[7.0]
  def change
    add_column :race_editions, :accepting_entries, :boolean, default: true
  end
end
