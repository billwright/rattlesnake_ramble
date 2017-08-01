class CreateRacers < ActiveRecord::Migration[5.1]
  def change
    create_table :racers do |t|
      t.string :first_name
      t.string :last_name
      t.integer :gender, default: 0
      t.string :email
      t.string :city
      t.string :state
      t.date :birth_date
      t.timestamps
    end
  end
end
