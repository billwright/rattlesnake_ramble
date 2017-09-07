FactoryGirl.define do
  factory :race_edition do
    date { FFaker::Time.date }
    race
    entry_fee { rand(10..1000) }
  end
end
