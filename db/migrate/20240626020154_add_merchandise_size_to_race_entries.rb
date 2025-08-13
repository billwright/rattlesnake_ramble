class AddMerchandiseSizeToRaceEntries < ActiveRecord::Migration[7.0]
  def change
    add_column :race_entries, :merchandise_size, :string, null: true
  end
end
