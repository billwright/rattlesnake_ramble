class CreateRaces < ActiveRecord::Migration[5.1]
  def change
    create_table :races do |t|
      t.string :name, null: false
      t.text :description
      t.text :location
      t.timestamps
    end
  end
end
