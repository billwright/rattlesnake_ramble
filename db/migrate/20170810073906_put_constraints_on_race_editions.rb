class PutConstraintsOnRaceEditions < ActiveRecord::Migration[5.1]
  def change
    change_column_null :race_editions, :race_id, false
    change_column_null :race_editions, :date, false
    add_foreign_key :race_editions, :races
  end
end
