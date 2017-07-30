class CreateRaceEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :race_entries do |t|
      t.integer :time
    end
  end
end
