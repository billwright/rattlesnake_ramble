class CreateRaceEditions < ActiveRecord::Migration[5.1]
  def change
    create_table :race_editions do |t|
      t.date :date
    end
  end
end
