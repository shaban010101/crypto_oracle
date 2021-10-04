# frozen_string_literal: true

# rubocop:disable Style/Documentation

class ErrorPresenter
  def initialize(errors)
    @errors = errors
  end

  def as_json
    { errors: @errors }.to_json
  end
end

# rubocop:enable Style/Documentation
