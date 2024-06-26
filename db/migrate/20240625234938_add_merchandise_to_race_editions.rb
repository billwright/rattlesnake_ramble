class AddMerchandiseToRaceEditions < ActiveRecord::Migration[7.0]
  def change
    add_column :race_editions, :selling_merchandise, :boolean, default: false
    add_column :race_editions, :merchandise_description, :string, null: true
    add_column :race_editions, :merchandise_image_file_name, :string, null: true
    add_column :race_editions, :merchandise_price, :integer, null: true
  end
end
