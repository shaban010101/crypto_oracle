require 'sinatra'
require 'net/http'
require 'uri'

API_KEY = ENV['API_KEY']

get '/api/currencies' do
  tickers = params[:tickers]
  uri = URI("https://api.nomics.com/v1/currencies/ticker?key=#{API_KEY}&ids=#{tickers}")
  Net::HTTP.get(uri)
end