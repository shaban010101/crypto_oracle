# frozen_string_literal: true

require 'net/http'
require 'uri'

class CurrencyApiRequest
  def initialize(dynamic_params, tickers)
    @dynamic_params = dynamic_params
    @tickers = tickers
  end

  def request
    uri = URI("https://api.nomics.com/v1/currencies/ticker?key=#{API_KEY}&ids=#{@tickers}&#{@dynamic_params}")
    response = Net::HTTP.get_response(uri)
    OpenStruct.new(status: response.code.to_i, body: response.body)
  end
end
