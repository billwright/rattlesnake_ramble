require 'rails_helper'

RSpec.describe OST::GetToken do
  describe '.perform' do
    let(:response) { OST::GetToken.perform }
    let(:example_email) { "ramble@example.com" }
    let(:example_password) { "password" }

    let(:expected_payload) do
      { user: { email: example_email, password: example_password } }
    end

    before do
      allow(RestClient).to receive(:post)
      allow(RambleConfig).to receive(:ost_email).and_return(example_email)
      allow(RambleConfig).to receive(:ost_password).and_return(example_password)
      allow(RambleConfig).to receive(:ost_url).and_return("https://www.opensplittime.org")
    end

    it 'returns an OST::Response containing a JSON Web Token' do
      expect(RestClient).to receive(:post).with("https://www.opensplittime.org/api/v1/auth", expected_payload)
      response
    end
  end
end
