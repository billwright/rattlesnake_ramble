require 'rails_helper'

# t.string "name"
# t.text "description"
# t.text "location"

RSpec.describe Race, type: :model do
  it { is_expected.to strip_attribute(:name).collapse_spaces }

  describe '#initialize' do
    it 'is valid when created with a name' do
      race = build_stubbed(:race)
      expect(race.name).to be_present
      expect(race).to be_valid
    end

    it 'is invalid when created without a name' do
      race = build_stubbed(:race, name: nil)
      expect(race).to be_invalid
      expect(race.errors.full_messages).to include("Name can't be blank")
    end

    it 'is invalid when created without a descriptive name' do
      race = build_stubbed(:race, name: 'RREY')
      expect(race).to be_invalid
      expect(race.errors.full_messages).to include("Name is too short (minimum is 5 characters)")
    end

    it 'is invalid when created with a duplicate name' do
      existing_race = create(:race)
      race = build_stubbed(:race, name: existing_race.name)
      expect(race).to be_invalid
      expect(race.errors.full_messages).to include('Name has already been taken')
    end
  end
end
