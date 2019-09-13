require 'rails_helper'

# t.date "date"
# t.integer "race_id"

RSpec.describe RaceEdition, type: :model do
  describe '#initialize' do
    it 'is valid when created with a date and race_id' do
      race_edition = build_stubbed(:race_edition)
      expect(race_edition.race_id).to be_present
      expect(race_edition.date).to be_present
      expect(race_edition.entry_fee).to be_present
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

    it 'is invalid when created with a duplicate race on the same date' do
      existing_race_edition = create(:race_edition)
      race_edition = build_stubbed(:race_edition, race: existing_race_edition.race, date: existing_race_edition.date)
      expect(race_edition).to be_invalid
      expect(race_edition.errors.full_messages).to include('Race has already been taken')
    end
  end

  describe '#male_offset_minutes' do
    subject { race_edition.male_offset_minutes }
    let(:race_edition) { build_stubbed(:race_edition, male_offset: male_offset) }
    let(:male_offset) { 0 }

    context 'when male_offset is 0' do
      it 'returns 0' do
        expect(subject).to eq(0)
      end
    end

    context 'when male_offset is a number of seconds divisible by 60' do
      let(:male_offset) { 15 * 60 }
      it 'returns the equivalent number of minutes as a float' do
        expect(subject).to eq(15)
        expect(subject).to be_a(Float)
      end
    end

    context 'when male_offset is a number of seconds not divisible by 60' do
      let(:male_offset) { 90 }
      it 'returns the equivalent number of minutes as a float' do
        expect(subject).to eq(1.5)
        expect(subject).to be_a(Float)
      end
    end
  end
end
