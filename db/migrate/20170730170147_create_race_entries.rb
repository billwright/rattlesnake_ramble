class CreateRaceEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :race_entries do |t|
      t.integer :racer_id
      t.integer :race_edition_id
      t.boolean :paid
      t.integer :time
      t.timestamps
    end
  end
end
