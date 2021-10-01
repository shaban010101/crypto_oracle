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

  before do
    stub_request(:get, "https://api.nomics.com/v1/currencies/ticker?key=#{API_KEY}&ids=BTC,ETH,XRP").
        with(
            headers: {
                'Accept' => '*/*',
                'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Host' => 'api.nomics.com',
                'User-Agent' => 'Ruby'
            }).to_return(status: 200, body: api_response)
  end

  it 'fetch currencies' do
    get '/api/currencies?tickers=BTC,ETH,XRP'
    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body)).to eq(JSON.parse(api_response))
  end
end