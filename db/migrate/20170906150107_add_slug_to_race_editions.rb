class AddSlugToRaceEditions < ActiveRecord::Migration[5.1]
  def up
    add_column :race_editions, :slug, :string
    add_index :race_editions, :slug, unique: true
    add_index :race_editions, [:race_id, :date], unique: true
    RaceEdition.find_each(&:save) # Adds slugs to all existing records
    # change_column_null :race_editions, :slug, false
  end

  def down
    # change_column_null :race_editions, :slug, true
    remove_index :race_editions, [:race_id, :date]
    remove_index :race_editions, :slug
    remove_column :race_editions, :slug
  end
end
