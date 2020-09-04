class AddScheduledStartTimeToRaceEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :race_entries, :scheduled_start_time, :datetime
  end
end
