require 'rails_helper'

RSpec.describe OST::GetToken do
  describe '.perform' do
    let(:response) { OST::GetToken.perform }

    it 'returns an OST::Response containing a JSON Web Token' do
      expect(response.token).to be_present
      expect(response.token.split('.').size).to eq(3)
    end
  end
end
