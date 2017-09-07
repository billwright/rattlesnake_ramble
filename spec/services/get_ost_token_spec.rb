require 'rails_helper'

RSpec.describe GetOstToken do
  describe '.perform' do
    it 'obtains a JSON Web Token from www.opensplittime.org' do
      token = GetOstToken.perform
      expect(token.split('.').size).to eq(3)
    end
  end
end
