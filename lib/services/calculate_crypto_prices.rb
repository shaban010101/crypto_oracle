# frozen_string_literal: true

require 'json'

# rubocop:disable Style/Documentation

class CalculateCryptoPrices
  def initialize(from, to, response)
    @from = from
    @to = to
    @response = JSON.parse(response)
  end

  def as_json
    @output.to_json
  end

  def calculate
    value = (from_price.to_f / to_price).round(3)
    @output = { "1 #{@from}" => "#{value} #{@to}" }
  end

  private

  def from_price
    @response.find { |currency| currency['symbol'] == @from }['price']
  end

  def to_price
    @response.find { |currency| currency['symbol'] == @to }['price']
  end
end

# rubocop:enable Style/Documentation
