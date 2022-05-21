require 'rails_helper'

# t.integer "racer_id", null: false
# t.integer "race_edition_id", null: false
# t.integer "time"
# t.boolean "paid", default: false
# t.integer "bib_number"
# t.datetime "scheduled_start_time"
# t.integer "predicted_time"

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
      existing_entry = create(:race_entry, :with_bib_number)
      new_entry = build(:race_entry, bib_number: existing_entry.bib_number, race_edition: existing_entry.race_edition)
      expect(new_entry).to be_invalid
      expect(new_entry.errors.full_messages).to include('Bib number may not be duplicated within a race edition')
    end

    it 'allows multiple nil bib_numbers' do
      existing_entry = create(:race_entry, bib_number: nil)
      new_entry = build(:race_entry, bib_number: nil, race_edition: existing_entry.race_edition)
      expect(new_entry).to be_valid
    end
  end

  describe 'time-related virtual attributes' do
    real_attributes = [:predicted_time, :time]

    real_attributes.each do |real_attribute|
      virtual_getter = "elapsed_#{real_attribute}"
      virtual_setter = "elapsed_#{real_attribute}="

      describe "##{virtual_getter}" do
        subject { build_stubbed(:race_entry, real_attribute => time) }
        let(:result) { subject.send(virtual_getter) }

        context 'when the time attribute is present' do
          let(:time) { 1800 }
          it 'returns a human-readable string representing elapsed time' do
            expect(result).to eq('30 mins')
          end
        end

        context 'when the time attribute contains a seconds component' do
          let(:time) { 1830 }
          it 'returns a human-readable string representing elapsed time' do
            expect(result).to eq('30 mins 30 secs')
          end
        end

        context 'when the time attribute is not present' do
          let(:time) { nil }
          it 'returns nil' do
            expect(result).to be_nil
          end
        end
      end

      describe "##{virtual_setter}" do
        subject { build_stubbed(:race_entry, time: nil) }
        let(:result) { subject.send(real_attribute) }

        before { subject.send(virtual_setter, time_string) }

        context 'when passed a human-readable string' do
          let(:time_string) { '30 mins' }
          it 'sets the time attribute to the equivalent number of seconds' do
            expect(result).to eq(1800)
          end
        end

        context 'when passed a human-readable string with seconds' do
          let(:time_string) { '30 mins 30 secs' }
          it 'sets the time attribute to the equivalent number of seconds' do
            expect(result).to eq(1830)
          end
        end

        context 'when passed a string in mm:ss format' do
          let(:time_string) { '30:30' }
          it 'sets the time attribute to the equivalent number of seconds' do
            expect(result).to eq(1830)
          end
        end

        context 'when passed a string in hh:mm:ss format' do
          let(:time_string) { '01:30:30' }
          it 'sets the time attribute to the equivalent number of seconds' do
            expect(result).to eq(5430)
          end
        end

        context 'when passed a string in h:mm:ss format' do
          let(:time_string) { '1:30:30' }
          it 'sets the time attribute to the equivalent number of seconds' do
            expect(result).to eq(5430)
          end
        end

        context 'when passed an empty string' do
          let(:time_string) { '' }
          it 'sets the time attribute to nil' do
            expect(result).to be_nil
          end
        end

        context 'when passed nil' do
          let(:time_string) { nil }
          it 'sets the time attribute to nil' do
            expect(result).to be_nil
          end
        end
      end
    end
  end
end
