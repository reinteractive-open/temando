require 'active_support/core_ext/hash/conversions'
require 'bigdecimal'

module Temando::Api
  module Entities
    # Handles turning a SOAP <quote> element into a Temando::Quote and
    # back again.
    class Quote
      def self.parse_xml(quote_xml)
        hash = Hash.from_xml(quote_xml)['quote']
        quote = Temando::Quote.new

        quote.total_price = BigDecimal.new(hash['totalPrice'])
        quote.tax         = BigDecimal.new(hash['tax'])
        quote.currency    = hash['currency']

        quote.name        = hash['deliveryMethod']

        quote.minimum_eta = hash['etaFrom'].to_i
        quote.maximum_eta = hash['etaTo'].to_i

        quote
      end
    end
  end
end
