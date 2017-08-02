require 'rails_helper'

# t.string "name"
# t.text "description"
# t.text "location"

RSpec.describe Race, type: :model do
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
  end
end
