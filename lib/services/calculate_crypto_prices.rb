# frozen_string_literal: true

require 'json'
require './lib/presenters/error_presenter'

# rubocop:disable Style/Documentation

class CalculateCryptoPrices
  def initialize(from, to, response)
    @from = from
    @to = to
    @response = JSON.parse(response)
  end

  def calculate
    return errors_object unless from_price && to_price

    # rubocop:disable Style/FloatDivision
    value = (from_price.to_f / to_price.to_f).round(3)
    # rubocop:enable Style/FloatDivision
    success_object(value)
  end

  private

  def errors_object
    OpenStruct.new(
      body: ErrorPresenter.new(['From/To values do not exist, please try values which do exist']).as_json,
      status: 422
    )
  end

  def success_object(value)
    OpenStruct.new(
      body: { "1 #{@from}" => "#{value} #{@to}" }.to_json,
      status: 200
    )
  end

  def from_price
    currency = @response.find { |crypto| crypto['symbol'] == @from }
    return nil unless currency

    currency['price']
  end

  def to_price
    currency = @response.find { |crypto| crypto['symbol'] == @to }
    return nil unless currency

    currency['price']
  end
end

# rubocop:enable Style/Documentation
