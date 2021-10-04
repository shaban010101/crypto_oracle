# frozen_string_literal: true

require './spec/spec_helper'
require './lib/services/currency_api_request'

RSpec.describe CurrencyApiRequest do
  describe '#request' do
    subject(:request) { described_class.new('convert=USD', 'BTC').request }
    let(:response) { double(code: '200', body: 'some body') }

    before do
      allow(Net::HTTP).to receive(:get_response).and_return(response)
    end

    it 'makes a request based on the provided parameters' do
      request
      expect(Net::HTTP).to have_received(:get_response).with(URI("https://api.nomics.com/v1/currencies/ticker?key=#{API_KEY}&ids=BTC&convert=USD"))
    end

    it 'outputs an object with the response status and body' do
      expect(request).to eq(OpenStruct.new(status: 200, body: 'some body'))
    end
  end
end
