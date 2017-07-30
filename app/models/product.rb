class Product < ActiveRecord::Base
  validates :description, presence: true
  validates :quantity, presence: true
end