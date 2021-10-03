# frozen_string_literal: true

class CurrenciesPresenter
  def initialize(response)
    @response = JSON.parse(response)
  end

  def present
    @response.map do |currency|
      {
        name: currency['name'],
        symbol: currency['symbol'],
        price: currency['price'],
        circulating_supply: currency['circulating_supply'],
        max_supply: currency['max_supply']
      }
    end
  end
end
