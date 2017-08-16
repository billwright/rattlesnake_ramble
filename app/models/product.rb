class Product < ActiveRecord::Base
  has_many :product_images, dependent: :destroy
  validates :description, presence: true
  validates :quantity, presence: true
  validates :price, presence: true
end