class CreateRaceEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :race_entries do |t|
      t.references :race_edition, foreign_key: true, null:false
      t.references :racer, foreign_key: true, null:false
      t.integer :time
      t.boolean :paid, default: false
      t.timestamps
      # t.index [:race_edition, :racer], unique: true, name: "index_race_entries_on_racer_id_and_race_edition_id"
    end
  end
end
