class RemoveDefaultFromRacerGender < ActiveRecord::Migration[5.1]
  def change
    change_column_default :racers, :gender, from: 0, to: nil
  end
end
