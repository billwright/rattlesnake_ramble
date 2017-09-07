require 'rails_helper'

RSpec.describe OST::GetToken do
  describe '.perform' do
    it 'obtains a JSON Web Token' do
      token = OST::GetToken.perform
      expect(token.split('.').size).to eq(3)
    end
  end
end
