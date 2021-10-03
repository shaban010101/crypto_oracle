# frozen_string_literal: true

# rubocop:disable Style/Documentation

class ErrorPresenter
  def initialize(reponsse)
    @response = reponsse
  end

  def as_json
    { errors: [@response.body] }.to_json
  end
end

# rubocop:enable Style/Documentation
