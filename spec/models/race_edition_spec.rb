require 'rails_helper'

# t.date "date"
# t.integer "race_id"

RSpec.describe RaceEdition, type: :model do
  describe '#initialize' do
    it 'is valid when created with a date and race_id' do
      race_edition = build_stubbed(:race_edition)
      expect(race_edition.race_id).to be_present
      expect(race_edition.date).to be_present
      expect(race_edition).to be_valid
    end

    it 'is invalid when created without a date' do
      race_edition = build_stubbed(:race_edition, date: nil)
      expect(race_edition).to be_invalid
      expect(race_edition.errors.full_messages).to include("Date can't be blank")
    end

    it 'is invalid when created without a race_id' do
      race_edition = build_stubbed(:race_edition, race_id: nil)
      expect(race_edition).to be_invalid
      expect(race_edition.errors.full_messages).to include("Race can't be blank")
    end
  end
end
