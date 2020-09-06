require 'rails_helper'

RSpec.describe OST::TranslateRaceEntry do
  describe '.perform' do
    let(:race_entry) { build_stubbed(:race_entry, race_edition: race_edition, racer: racer, bib_number: 123, scheduled_start_time: scheduled_start_time) }
    let(:race_edition) { build_stubbed(:race_edition, date: start_date, default_start_time_male: default_start_time_male, default_start_time_female: default_start_time_female) }
    let(:start_date) { '2020-09-12'.to_date }
    let(:scheduled_start_time) { nil }
    let(:default_start_time_male) { start_date.to_datetime + 10.hours }
    let(:default_start_time_female) { start_date.to_datetime + 10.5.hours }

    context 'when the race entry has no scheduled start time' do
      context 'when the racer is male' do
        let(:racer) { build_stubbed(:racer, :male, first_name: 'Johnny', last_name: 'Appleseed', birth_date: '1999-10-01',
                                    city: 'Boulder', state: 'CO', email: 'johnny@appleseed.com') }

        it 'translates a race_entry (with associated racer) into an OST-compatible attribute set with male start time' do
          translation = OST::TranslateRaceEntry.perform(race_entry)
          expect(translation).to eq(type: 'efforts',
                                    attributes: { gender: 'male',
                                                  first_name: 'Johnny',
                                                  last_name: 'Appleseed',
                                                  birthdate: Date.parse('1999-10-01'),
                                                  city: 'Boulder',
                                                  state_code: 'CO',
                                                  email: 'johnny@appleseed.com',
                                                  bib_number: 123,
                                                  scheduled_start_time: default_start_time_male })
        end
      end

      context 'when the racer is female' do
        let(:racer) { build_stubbed(:racer, :female, first_name: 'Jane', last_name: 'Appleseed', birth_date: '1999-10-01',
                                    city: 'Boulder', state: 'CO', email: 'johnny@appleseed.com') }

        it 'translates a race_entry (with associated racer) into an OST-compatible attribute set with female start time' do
          translation = OST::TranslateRaceEntry.perform(race_entry)
          expect(translation).to eq(type: 'efforts',
                                    attributes: { gender: 'female',
                                                  first_name: 'Jane',
                                                  last_name: 'Appleseed',
                                                  birthdate: Date.parse('1999-10-01'),
                                                  city: 'Boulder',
                                                  state_code: 'CO',
                                                  email: 'johnny@appleseed.com',
                                                  bib_number: 123,
                                                  scheduled_start_time: default_start_time_female })
        end
      end
    end

    context 'when the race entry has a scheduled start time' do
      let(:scheduled_start_time) { default_start_time_female + 5.minutes }
      let(:racer) { build_stubbed(:racer, :female, first_name: 'Jane', last_name: 'Appleseed', birth_date: '1999-10-01',
                                  city: 'Boulder', state: 'CO', email: 'johnny@appleseed.com') }

      it 'translates a race_entry (with associated racer) into an OST-compatible attribute set with female start time' do
        translation = OST::TranslateRaceEntry.perform(race_entry)
        expect(translation).to eq(type: 'efforts',
                                  attributes: { gender: 'female',
                                                first_name: 'Jane',
                                                last_name: 'Appleseed',
                                                birthdate: Date.parse('1999-10-01'),
                                                city: 'Boulder',
                                                state_code: 'CO',
                                                email: 'johnny@appleseed.com',
                                                bib_number: 123,
                                                scheduled_start_time: scheduled_start_time })
      end
    end
  end
end
