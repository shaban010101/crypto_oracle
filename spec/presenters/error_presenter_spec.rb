# frozen_string_literal: true

require './lib/presenters/error_presenter'
require './spec/spec_helper'

RSpec.describe ErrorPresenter do
  describe '#as_json' do
    subject(:presenter) { described_class.new(['Authentication failed']) }

    it 'outputs the errors as json' do
      expect(presenter.as_json).to eq(JSON.generate({ errors: ['Authentication failed'] }))
    end
  end
end
