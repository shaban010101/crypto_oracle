require 'sinatra'
require 'net/http'
require 'uri'
require 'json'
require './lib/forms/currencies_form'
require './lib/presenters/currencies_presenter'
require './lib/services/currency_api_request'

API_KEY = ENV['API_KEY']

get '/api/currencies' do
  currencies_form = CurrenciesForm.new(params)

  if currencies_form.valid?
    dynamic_params = URI.encode_www_form(currencies_form.attributes.except('tickers'))
    response = CurrencyApiRequest.new(dynamic_params, params[:tickers]).request
    CurrenciesPresenter.new(response).present.to_json
  else
    status 422
    { errors: currencies_form.errors.full_messages }.to_json
  end
end

get '/api/currencies/fiat' do
  response = CurrencyApiRequest.new("convert=#{params[:fiat_currency]}", params[:crypto_currency]).request
  json_response = JSON.parse(response)
  { fiat_price: json_response.first['price'], currency: params[:fiat_currency] }.to_json
end