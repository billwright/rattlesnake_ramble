class PutConstraintsOnRacers < ActiveRecord::Migration[5.1]
  def change
    change_column_null :racers, :first_name, false
    change_column_null :racers, :last_name, false
    change_column_null :racers, :gender, false
    change_column_null :racers, :email, false
    change_column_null :racers, :birth_date, false
  end
end
