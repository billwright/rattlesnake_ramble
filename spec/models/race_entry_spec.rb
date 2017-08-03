require 'rails_helper'

# t.integer "racer_id"
# t.integer "race_edition_id"
# t.integer "time"

RSpec.describe RaceEntry, type: :model do
  describe '#initialize' do
    it 'is valid when created with a racer and a race_edition' do
      race_entry = build_stubbed(:race_entry)
      expect(race_entry.racer).to be_present
      expect(race_entry.race_edition).to be_present
      expect(race_entry).to be_valid
    end

    it 'is invalid when created without a racer' do
      race_entry = build_stubbed(:race_entry, racer: nil)
      expect(race_entry).to be_invalid
      expect(race_entry.errors.full_messages).to include("Racer can't be blank")
    end

    it 'is invalid when created without a race_edition' do
      race_entry = build_stubbed(:race_entry, race_edition: nil)
      expect(race_entry).to be_invalid
      expect(race_entry.errors.full_messages).to include("Race edition can't be blank")
    end
  end
end
