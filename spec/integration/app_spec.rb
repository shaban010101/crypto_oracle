# frozen_string_literal: true

ENV['APP_ENV'] = 'test'

require './app'
require 'rspec'
require 'rack/test'
require './spec/spec_helper'

API_KEY = ENV['API_KEY']

RSpec.describe 'app' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  let(:api_response) do
    File.read('spec/fixtures/currencies_api_response.json')
  end

  describe 'GET /api/currencies' do
    context 'when valid parameters are provided' do
      let(:expected_response) do
        [
          {
            name: 'Bitcoin',
            symbol: 'BTC',
            price: '48135.84174593',
            circulating_supply: '18831712',
            max_supply: '21000000'
          },
          {
            name: 'Ethereum',
            symbol: 'ETH',
            price: '3281.22963113',
            circulating_supply: '117753964',
            max_supply: nil
          },
          {
            name: 'XRP',
            symbol: 'XRP',
            price: '1.02691563',
            circulating_supply: '46750439262',
            max_supply: '100000000000'
          }
        ].each(&:stringify_keys!)
      end

      before do
        stub_request(:get, "https://api.nomics.com/v1/currencies/ticker?key=#{API_KEY}&ids=BTC,ETH,XRP&page=1&interval=1d,7d,30d,365d,ytd&per_page=100")
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Host' => 'api.nomics.com',
              'User-Agent' => 'Ruby'
            }
          ).to_return(status: 200, body: api_response)
      end

      it 'fetch currencies' do
        get '/api/currencies?tickers=BTC,ETH,XRP'
        expect(last_response).to be_ok
        expect(JSON.parse(last_response.body)).to eq(expected_response)
      end
    end

    context 'when invalid parameters are provided' do
      let(:api_response) do
        {
          'errors' => ['Interval not valid use either/all of these 1d,7d,30d,365d,ytd as accepted intervals']
        }
      end

      it 'responds unsucessfully' do
        get '/api/currencies?tickers=BTC,ETH,XRP&interval=1dd'
        expect(last_response.status).to eq(422)
        expect(JSON.parse(last_response.body)).to eq(api_response)
      end
    end
  end

  describe 'GET api/currencies/fiat' do
    before do
      stub_request(:get, "https://api.nomics.com/v1/currencies/ticker?key=#{API_KEY}&ids=BTC&convert=USD")
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Host' => 'api.nomics.com',
            'User-Agent' => 'Ruby'
          }
        ).to_return(status: 200, body: api_response)
    end

    it 'responds with the fiat price' do
      get '/api/currencies/fiat?fiat_currency=USD&crypto_currency=BTC'
      expect(last_response).to be_ok
      expect(JSON.parse(last_response.body).symbolize_keys).to eq({ currency: 'USD', fiat_price: '48135.84174593' })
    end
  end
end
