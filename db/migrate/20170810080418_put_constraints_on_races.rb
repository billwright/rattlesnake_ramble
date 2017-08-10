class PutConstraintsOnRaces < ActiveRecord::Migration[5.1]
  def change
    change_column_null :races, :name, false
  end
end
