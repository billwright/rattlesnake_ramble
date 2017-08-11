class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :description, null: false
      t.integer :quantity, null: false
      t.timestamps
    end
  end
end
