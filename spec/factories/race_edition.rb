FactoryGirl.define do
  factory :race_edition do
    date FFaker::Time.date
    race
  end
end
