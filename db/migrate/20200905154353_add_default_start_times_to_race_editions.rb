class AddDefaultStartTimesToRaceEditions < ActiveRecord::Migration[5.1]
  def change
    add_column :race_editions, :default_start_time_male, :datetime
    add_column :race_editions, :default_start_time_female, :datetime
  end
end
