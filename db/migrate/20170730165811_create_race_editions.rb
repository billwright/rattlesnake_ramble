class CreateRaceEditions < ActiveRecord::Migration[5.1]
  def change
    create_table :race_editions do |t|
      t.references :race, foreign_key: true, null:false
      t.date :date, null: false
      t.integer :entry_fee, null: false
      t.timestamps
    end
  end
end
