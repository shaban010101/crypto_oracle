# frozen_string_literal: true

require './spec/spec_helper'
require './lib/services/calculate_crypto_prices'

RSpec.describe CalculateCryptoPrices do
  subject { described_class.new('BTC', 'ETH', api_response) }

  let(:api_response) do
    File.read('spec/fixtures/currencies_api_response.json')
  end

  describe '#calculate' do
    context 'when both currencies have been found' do
      it 'calculates the price from one crypto to another' do
        expect(subject.calculate).to eq(OpenStruct.new(body: { '1 BTC' => '14.67 ETH' }.to_json, status: 200))
      end
    end

    context 'when one of currencies have been found' do
      let(:api_response) { [].to_json }

      it 'outputs an error message' do
        expect(subject.calculate).to eq(OpenStruct.new(
                                          body: { errors: ['From/To values do not exist, please try values which do exist'] }.to_json, status: 422
                                        ))
      end
    end
  end
end
