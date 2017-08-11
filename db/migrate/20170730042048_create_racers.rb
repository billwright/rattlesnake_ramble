class CreateRacers < ActiveRecord::Migration[5.1]
  def change
    create_table :racers do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.integer :gender, default: 0
      t.string :email, null: false
      t.string :city
      t.string :state
      t.date :birth_date, null: false
      t.timestamps
    end
  end
end
