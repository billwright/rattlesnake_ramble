class Product < ActiveRecord::Base
  has_many :product_images
  validates :description, presence: true
  validates :quantity, presence: true
  validates :price, presence: true
end