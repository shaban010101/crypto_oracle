# frozen_string_literal: true

require 'active_model'

class CalculateCurrenciesForm
  include ActiveModel::Model

  attr_accessor :from, :to

  validates :from, :to, presence: true
end
