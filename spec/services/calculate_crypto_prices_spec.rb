# frozen_string_literal: true

require './spec/spec_helper'
require './lib/services/calculate_crypto_prices'

RSpec.describe CalculateCryptoPrices do
  subject { described_class.new('BTC', 'ETH', api_response) }

  let(:api_response) do
    File.read('spec/fixtures/currencies_api_response.json')
  end

  describe '#calculate' do
    it 'calculates the price from one crypto to another' do
      expect(subject.calculate).to eq({ '1 BTC' => '14.67 ETH' })
    end
  end

  describe 'as_json' do
    it 'calculates the price from one crypto to another' do
      subject.calculate
      expect(subject.as_json).to eq(JSON.generate({ '1 BTC' => '14.67 ETH' }))
    end
  end
end
