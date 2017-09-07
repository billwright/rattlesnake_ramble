require 'rails_helper'

RSpec.describe OST::TranslateRaceEntry do
  describe '.perform' do
    let(:racer) { build_stubbed(:racer, :male, first_name: 'Johnny', last_name: 'Appleseed', birth_date: '1999-10-01', city: 'Boulder', state: 'CO', email: 'johnny@appleseed.com') }
    let(:race_entry) { build_stubbed(:race_entry, racer: racer) }

    it 'translates a race_entry (with associated racer) into an OST-compatible attribute set' do
      translation = OST::TranslateRaceEntry.perform(race_entry)
      expect(translation).to eq({gender: 'male', first_name: 'Johnny', last_name: 'Appleseed', birthdate: Date.parse('1999-10-01'), city: 'Boulder', state_code: 'CO', email: 'johnny@appleseed.com'})
    end
  end
end
