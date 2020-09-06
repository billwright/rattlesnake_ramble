class RemoveOffsetsFromRaceEditions < ActiveRecord::Migration[5.1]
  def change
    remove_column :race_editions, :male_offset, :integer, default: 0
    remove_column :race_editions, :female_offset, :integer, default: 0
  end
end
