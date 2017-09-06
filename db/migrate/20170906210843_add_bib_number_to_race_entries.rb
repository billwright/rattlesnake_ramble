class AddBibNumberToRaceEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :race_entries, :bib_number, :integer
  end
end
