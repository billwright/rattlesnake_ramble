class PutConstraintsOnProducts < ActiveRecord::Migration[5.1]
  def change
    change_column_null :products, :description, false
    change_column_null :products, :quantity, false
  end
end
