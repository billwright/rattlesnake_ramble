FactoryGirl.define do
  factory :race_entry do
    race_edition
    racer

    trait :with_bib_number do
      bib_number { rand(1..999) }
    end
  end
end
