class AddShortNameToRaces < ActiveRecord::Migration[6.0]
  def change
    add_column :races, :short_name, :string
  end
end
