class CreateProductImages < ActiveRecord::Migration[5.1]
  def change
    create_table :product_images do |t|
      t.references :product, foreign_key: true, null:false
      t.string :url, null:false
      t.string :alt_text

      t.timestamps
    end
  end
end
