# frozen_string_literal: true

require './spec/spec_helper'
require './lib/forms/calculate_currencies_form'

RSpec.describe CalculateCurrenciesForm do
  subject(:form) do
    described_class.new(to: 'BTC', from: 'ETH')
  end

  describe 'validations' do
    it 'valid with valid attributes' do
      expect(form).to be_valid
    end

    it 'invalid with a non numerical page' do
      form.to = nil
      expect(form).to_not be_valid
    end

    it 'invalid with a non inclusive per_page' do
      form.from = nil
      expect(subject).to_not be_valid
    end
  end
end
