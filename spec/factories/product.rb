FactoryBot.define do
  factory :product do
    description { FFaker::Product.product }
    quantity { rand(0..20) }
    price { rand(10..1000) }

    trait :out_of_stock do
      quantity { 0 }
    end

    trait :in_stock do
      quantity { rand(1..20) }
    end
  end
end
