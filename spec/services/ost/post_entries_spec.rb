require 'rails_helper'

RSpec.describe OST::PostEntries do
  describe '.perform' do
    let(:race_edition) { build_stubbed(:race_edition, race_entries: race_entries) }
    let(:race_entries) { build_stubbed_list(:race_entry, 3, :with_bib_number) }
    let(:token) { '123.abc.456' }

    it 'sends a properly constructed URL to RestClient' do
      allow(RestClient).to receive(:post)
      OST::PostEntries.perform(race_edition: race_edition, ost_event_id: 'test-event', token: token)
      expected_url = "#{ENV['OST_URL']}/api/v1/events/test-event/import"
      expect(RestClient).to have_received(:post).with(expected_url, anything, anything)
    end

    it 'sends a data payload to RestClient' do
      allow(RestClient).to receive(:post)
      OST::PostEntries.perform(race_edition: race_edition, ost_event_id: 'test-event', token: token)
      expect(RestClient).to have_received(:post).with(anything, hash_including(:data, :data_format, :unique_key), anything)
    end

    it 'sends the given token to RestClient in an Authorization header' do
      allow(RestClient).to receive(:post)
      OST::PostEntries.perform(race_edition: race_edition, ost_event_id: 'test-event', token: token)
      expected_authorization = {Authorization: 'Bearer 123.abc.456'}
      expect(RestClient).to have_received(:post).with(anything, anything, expected_authorization)
    end
  end
end
