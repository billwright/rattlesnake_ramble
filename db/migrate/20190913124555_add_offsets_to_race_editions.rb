class AddOffsetsToRaceEditions < ActiveRecord::Migration[5.1]
  def change
    add_column :race_editions, :male_offset, :integer, default: 0
    add_column :race_editions, :female_offset, :integer, default: 0
  end
end
