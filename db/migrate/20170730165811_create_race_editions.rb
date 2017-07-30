class CreateRaceEditions < ActiveRecord::Migration[5.1]
  def change
    create_table :race_editions do |t|
      t.integer :race_id
      t.date :date
      t.timestamps
    end
  end
end
