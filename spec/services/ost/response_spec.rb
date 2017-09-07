require 'rails_helper'

RSpec.describe OST::Response do
  subject { OST::Response.new(rest_client_response) }

  describe '#body' do
    let(:body) { "{\"token\":\"123.abc.456\"}" }
    let(:rest_client_response) { instance_double('RestClient::Response', code: 200, body: body) }

    it 'returns the code from the response' do
      expect(subject.body).to eq(body)
    end
  end

  describe '#code' do
    let(:rest_client_response) { instance_double('RestClient::Response', code: 200, body: "{\"token\":\"123.abc.456\"}") }

    it 'returns the code from the response' do
      expect(subject.code).to eq(200)
    end
  end

  describe '#data' do
    context 'when data exists in the response' do
      let(:body) { "{\"data\":[{\"id\":\"11529\",\"type\":\"efforts\",\"attributes\":{\"firstName\":\"Bill\",\"lastName\":\"Wright\",\"gender\":\"male\"}}]}" }
      let(:rest_client_response) { instance_double('RestClient::Response', code: 401, body: body) }

      it 'returns the data' do
        expect(subject.data.count).to eq(1)
        expect(subject.data).to eq([{'id' => '11529', 'type' => 'efforts', 'attributes' => {'firstName' => 'Bill', 'lastName' => 'Wright', 'gender' => 'male'}}])
      end
    end

    context 'when no errors exist in the response' do
      let(:rest_client_response) { instance_double('RestClient::Response', code: 200, body: "{\"token\":\"123.abc.456\"}") }

      it 'returns nil' do
        expect(subject.errors).to be_nil
      end
    end
  end

  describe '#errors' do
    context 'when errors exist in the response' do
      let(:rest_client_response) { instance_double('RestClient::Response', code: 401, body: "{\"errors\":\"unauthorized\"}") }

      it 'returns the errors' do
        expect(subject.errors).to eq('unauthorized')
      end
    end

    context 'when no errors exist in the response' do
      let(:rest_client_response) { instance_double('RestClient::Response', code: 200, body: "{\"token\":\"123.abc.456\"}") }

      it 'returns nil' do
        expect(subject.errors).to be_nil
      end
    end
  end

  describe '#headers' do
    let(:headers) { {server: 'Cowboy', date: 'Thu, 07 Sep 2017 16:25:11 GMT'} }
    let(:rest_client_response) { instance_double('RestClient::Response', code: 200, headers: headers) }

    it 'returns the code from the response' do
      expect(subject.headers).to eq(headers)
    end
  end

  describe '#parsed_body' do
    let(:body) { "{\"token\":\"123.abc.456\"}" }
    let(:rest_client_response) { instance_double('RestClient::Response', code: 200, body: body) }

    it 'returns a JSON parsed version of the body' do
      expect(subject.parsed_body).to eq(JSON.parse(body))
    end
  end

  describe '#successful?' do
    context 'when the underlying RestClient response code is 200' do
      let(:rest_client_response) { instance_double('RestClient::Response', code: 200) }

      it 'returns true' do
        expect(subject.successful?).to eq(true)
      end
    end

    context 'when the underlying RestClient response code is 201' do
      let(:rest_client_response) { instance_double('RestClient::Response', code: 201) }

      it 'returns true' do
        expect(subject.successful?).to eq(true)
      end
    end

    context 'when the underlying RestClient response code is anything other than 200 or 201' do
      let(:rest_client_response) { instance_double('RestClient::Response', code: 401) }

      it 'returns false' do
        expect(subject.successful?).to eq(false)
      end
    end
  end

  describe '#token' do
    context 'when a token exists' do
      let(:rest_client_response) { instance_double('RestClient::Response', code: 200, body: "{\"token\":\"123.abc.456\"}") }

      it 'returns the token from the response body' do
        expect(subject.token).to eq('123.abc.456')
      end
    end

    context 'when no token exists' do
      let(:rest_client_response) { instance_double('RestClient::Response', code: 401, body: "{\"errors\":\"unauthorized\"}") }

      it 'returns the token from the response body' do
        expect(subject.token).to be_nil
      end
    end
  end
end
