# frozen_string_literal: true

ENV['APP_ENV'] = 'test'

require './lib/forms/currencies_form'
require './spec/spec_helper'

RSpec.describe CurrenciesForm do
  subject(:form) do
    described_class.new(page: 1,
                        per_page: 100,
                        interval: '1d')
  end

  describe 'validations' do
    it 'valid with valid attributes' do
      expect(form).to be_valid
    end

    it 'invalid with a non numerical page' do
      form.page = 'this'
      expect(form).to_not be_valid
    end

    it 'invalid with a non inclusive per_page' do
      form.per_page = 199
      expect(subject).to_not be_valid
    end

    it 'invalid with an non inclusive per_page' do
      form.per_page = 'sum'
      expect(subject).to_not be_valid
    end

    it 'invalid with an non inclusive interval' do
      form.interval = '177d, 18d'
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to eq(['Interval not valid use either/all of these 1d,7d,30d,365d,ytd as accepted intervals'])
    end
  end

  describe 'default attributes' do
    subject(:form) do
      described_class.new(page: nil,
                          per_page: nil,
                          interval: nil)
    end

    it 'sets default attributes when non are provided' do
      expect(form.attributes.symbolize_keys).to include(
        {
          page: 1, per_page: 100, interval: '1d,7d,30d,365d,ytd', tickers: nil
        }
      )
    end
  end
end
