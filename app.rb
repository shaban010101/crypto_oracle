# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require 'net/http'
require 'uri'
require 'json'
require './lib/forms/currencies_form'
require './lib/presenters/currencies_presenter'
require './lib/services/currency_api_request'
require './lib/services/calculate_crypto_prices'
require './lib/presenters/error_presenter'

API_KEY = ENV['API_KEY']

get '/api/currencies' do
  currencies_form = CurrenciesForm.new(params)

  halt 422, ErrorPresenter.new(currencies_form.errors.full_messages).as_json unless currencies_form.valid?

  dynamic_params = URI.encode_www_form(currencies_form.attributes.except('tickers'))
  response = CurrencyApiRequest.new(dynamic_params, params[:tickers]).request

  if response.status == 200
    CurrenciesPresenter.new(response.body).present.to_json
  else
    status response.status
    ErrorPresenter.new([response.body]).as_json
  end
end

get '/api/currencies/fiat' do
  response = CurrencyApiRequest.new("convert=#{params[:fiat_currency]}", params[:crypto_currency]).request
  if response.status == 200
    json_response = JSON.parse(response.body)
    { fiat_price: json_response.first['price'], currency: params[:fiat_currency] }.to_json
  else
    status response.status
    ErrorPresenter.new([response.body]).as_json
  end
end

get '/api/currencies/calculate' do
  response = CurrencyApiRequest.new('convert=USD', "#{params[:from]},#{params[:to]}").request

  if response.status == 200
    calculation = CalculateCryptoPrices.new(params[:from], params[:to], response.body)
    calculation.calculate
    calculation.as_json
  else
    status response.status
    ErrorPresenter.new([response.body]).as_json
  end
end
