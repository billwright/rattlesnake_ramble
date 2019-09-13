require 'rails_helper'

RSpec.describe OST::TranslateRaceEntry do
  describe '.perform' do
    let(:race_entry) { build_stubbed(:race_entry, race_edition: race_edition, racer: racer, bib_number: 123) }
    let(:race_edition) { build_stubbed(:race_edition, male_offset: male_offset, female_offset: female_offset) }
    let(:male_offset) { 0 }
    let(:female_offset) { 900 }

    context 'when the racer is male' do
      let(:racer) { build_stubbed(:racer, :male, first_name: 'Johnny', last_name: 'Appleseed', birth_date: '1999-10-01',
                                  city: 'Boulder', state: 'CO', email: 'johnny@appleseed.com') }

      it 'translates a race_entry (with associated racer) into an OST-compatible attribute set with male offset' do
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
                                                scheduled_start_offset: male_offset })
      end
    end

    context 'when the racer is female' do
      let(:racer) { build_stubbed(:racer, :female, first_name: 'Jane', last_name: 'Appleseed', birth_date: '1999-10-01',
                                  city: 'Boulder', state: 'CO', email: 'johnny@appleseed.com') }

      it 'translates a race_entry (with associated racer) into an OST-compatible attribute set with female offset' do
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
                                                scheduled_start_offset: female_offset })
      end
    end
  end
end
