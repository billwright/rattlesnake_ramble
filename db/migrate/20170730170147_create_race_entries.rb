class CreateRaceEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :race_entries do |t|
      t.time :time
    end
  end
end
