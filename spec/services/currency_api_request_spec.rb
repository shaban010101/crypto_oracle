# frozen_string_literal: true

require './spec/spec_helper'
require './lib/services/currency_api_request'

API_KEY = ENV['API_KEY']

RSpec.describe CurrencyApiRequest do
  describe '#request' do
    subject(:request) { described_class.new('convert=USD', 'BTC').request }

    before do
      allow(Net::HTTP).to receive(:get)
    end

    it 'makes a request based on the provided parameters' do
      request
      expect(Net::HTTP).to have_received(:get).with(URI("https://api.nomics.com/v1/currencies/ticker?key=#{API_KEY}&ids=BTC&convert=USD"))
    end
  end
end
