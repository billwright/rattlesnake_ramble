FactoryGirl.define do
  factory :racer do
    first_name FFaker::Name.first_name_male
    last_name FFaker::Name.last_name
    gender FFaker::Gender.random
    email FFaker::Internet.disposable_email
    birth_date FFaker::Time.date

    trait :male do
      gender :male
    end

    trait :female do
      gender :female
    end
  end
end
