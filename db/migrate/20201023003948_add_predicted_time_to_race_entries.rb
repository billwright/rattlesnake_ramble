class AddPredictedTimeToRaceEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :race_entries, :predicted_time, :integer
  end
end
