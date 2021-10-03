require 'sinatra'
require 'net/http'
require 'uri'
require 'json'
require './lib/forms/currencies_form'

API_KEY = ENV['API_KEY']

get '/api/currencies' do
  currencies_form = CurrenciesForm.new(params)

  if currencies_form.valid?
    dynamic_params = URI.encode_www_form(currencies_form.attributes.except('tickers'))
    uri = URI("https://api.nomics.com/v1/currencies/ticker?key=#{API_KEY}&ids=#{params[:tickers]}&#{dynamic_params}")
    Net::HTTP.get(uri)
  else
    status 422
    { errors: currencies_form.errors.full_messages }.to_json
  end
end