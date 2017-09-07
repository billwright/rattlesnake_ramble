class AddSlugToRaces < ActiveRecord::Migration[5.1]
  def up
    add_column :races, :slug, :string
    add_index :races, :slug, unique: true
    add_index :races, :name, unique: true
    Race.find_each(&:save)  # Adds slugs to all existing records
    # change_column_null :races, :slug, false
  end

  def down
    # change_column_null :races, :slug, true
    remove_index :races, :name
    remove_index :races, :slug
    remove_column :races, :slug
  end
end
