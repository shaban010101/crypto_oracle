# frozen_string_literal: true

require 'active_model'

class CurrenciesForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_accessor :tickers, :page, :per_page, :interval

  attribute :page, :integer, default: -> { 1 }
  attribute :per_page, :integer, default: -> { 100 }
  attribute :interval, default: -> { %w[1d 7d 30d 365d ytd].join(',') }
  attribute :tickers, :string

  validates :page, numericality: { only_integer: true }, allow_nil: true
  validates :per_page, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100 },
                       allow_nil: true
  validate :validates_interval

  private

  def validates_interval
    return true if interval.nil?

    included = interval.split(',').all? { |int| %w[1d 7d 30d 365d ytd].include?(int) }

    errors.add(:interval, 'not valid use either/all of these 1d,7d,30d,365d,ytd as accepted intervals') unless included
  end
end
