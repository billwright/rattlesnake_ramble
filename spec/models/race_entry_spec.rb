require 'rails_helper'

# t.integer "racer_id"
# t.integer "race_edition_id"
# t.integer "time"
# t.boolean "paid", default: false
# t.integer "bib_number"

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

    it 'is invalid when a race_entry already exists for the racer and race_edition' do
      existing_entry = create(:race_entry)
      new_entry = build(:race_entry, racer: existing_entry.racer, race_edition: existing_entry.race_edition)
      expect(new_entry).to be_invalid
      expect(new_entry.errors.full_messages).to include('Racer may be added to a race_edition only once')
    end

    it 'is invalid when a bib_number already exists within the race_edition' do
      existing_entry = create(:race_entry)
      new_entry = build(:race_entry, bib_number: existing_entry.bib_number, race_edition: existing_entry.race_edition)
      expect(new_entry).to be_invalid
      expect(new_entry.errors.full_messages).to include('Bib number may not be duplicated within a race edition')
    end
  end

  describe '#elapsed_time' do
    context 'when the time attribute is present' do
      subject { build_stubbed(:race_entry, time: 1800) }

      it 'returns a human-readable string representing elapsed time' do
        expect(subject.elapsed_time).to eq('30 mins')
      end
    end

    context 'when the time attribute is not present' do
      subject { build_stubbed(:race_entry, time: nil) }

      it 'returns "NA"' do
        expect(subject.elapsed_time).to eq('NA')
      end
    end
  end

  describe '#elapsed_time=' do
    context 'when passed a human-readable string' do
      subject { build_stubbed(:race_entry, time: nil)}
      let(:time_string) { '30 mins' }

      it 'sets the time attribute to the equivalent number of seconds' do
        subject.elapsed_time = time_string
        expect(subject.time).to eq(1800)
      end
    end

    context 'when passed an empty string' do
      subject { build_stubbed(:race_entry, time: 1800)}
      let(:time_string) { '' }

      it 'sets the time attribute to nil' do
        subject.elapsed_time = time_string
        expect(subject.time).to be_nil
      end
    end

    context 'when passed nil' do
      subject { build_stubbed(:race_entry, time: 1800)}
      let(:time_string) { nil }

      it 'sets the time attribute to nil' do
        subject.elapsed_time = time_string
        expect(subject.time).to be_nil
      end
    end
  end
end
