# frozen_string_literal: true

require './lib/presenters/fiat_currency_presenter'
require './spec/spec_helper'

RSpec.describe FiatCurrencyPresenter do
  describe '#as_json' do
    let(:api_response) do
      File.read('spec/fixtures/currencies_api_response.json')
    end
    context 'when the fiat currency has been provided' do
      subject(:present) { described_class.new(api_response, 'USD') }

      it 'outputs the response body as json' do
        expect(present.as_json).to eq(JSON.generate({ fiat_price: '48135.84174593', currency: 'USD' }))
      end
    end

    context 'when the fiat currency is nil' do
      subject(:present) { described_class.new(api_response, nil) }

      it 'outputs the response body as json' do
        expect(present.as_json).to eq(JSON.generate({ fiat_price: '48135.84174593', currency: 'USD' }))
      end
    end
  end
end
