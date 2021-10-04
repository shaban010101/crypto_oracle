# frozen_string_literal: true

# rubocop:disable Style/Documentation

class FiatCurrencyPresenter
  def initialize(response, fiat_currency)
    @response = JSON.parse(response)
    @fiat_currency = fiat_currency
  end

  def as_json
    { fiat_price: @response.first['price'], currency: currency }.to_json
  end

  private

  def currency
    return 'USD' unless @fiat_currency

    @fiat_currency
  end
end

# rubocop:enable Style/Documentation
