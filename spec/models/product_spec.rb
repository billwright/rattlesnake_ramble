require 'rails_helper'

# t.string "description"
# t.integer "quantity"

RSpec.describe Product, type: :model do
  describe '#initialize' do
    it 'is valid when created with a description and quantity' do
      product = build_stubbed(:product)
      expect(product.description).to be_present
      expect(product.quantity).to be_present
      expect(product).to be_valid
    end

    it 'is invalid when created without a description' do
      product = build_stubbed(:product, description: nil)
      expect(product).to be_invalid
      expect(product.errors.full_messages).to include("Description can't be blank")
    end

    it 'is invalid when created without a quantity' do
      product = build_stubbed(:product, quantity: nil)
      expect(product).to be_invalid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end
  end
end
