# frozen_string_literal: true

class CurrencyApiRequest
  def initialize(dynamic_params, tickers)
    @dynamic_params = dynamic_params
    @tickers = tickers
  end

  def request
    uri = URI("https://api.nomics.com/v1/currencies/ticker?key=#{API_KEY}&ids=#{@tickers}&#{@dynamic_params}")
    Net::HTTP.get(uri)
  end
end
