require 'active_support/core_ext/hash/conversions'
require 'bigdecimal'

module Temando::Api
  module Entities
    # Handles turning a SOAP <quote> element into a Temando::Quote and
    # back again.
    class Quote

      MAPPINGS = [ [ :total_price, :totalPrice ],
                   [ :base_price, :basePrice ],
                   :tax,
                   :currency,
                   [ :name, :deliveryMethod ],
                   [ :minimum_eta, :etaFrom ],
                   [ :maximum_eta, :etaTo ],
                   [ :guaranteed_eta_string, :guaranteedEta ],
                   [ :carrier_id, :carrierId ]
                 ]

      def initialize(quote=nil)
        @quote = quote
      end

      def build_xml(xml)
        xml.quote do
          xml.parent.namespace = nil

          MAPPINGS.each do |definition|
            if definition.is_a?(Array) then
              source = @quote.send(definition[0])
              xml.send(definition[1], source) if source.present?
            else
              source = @quote.send(definition)
              xml.send(definition, source) if source.present?
            end
          end
        end
      end

      def self.parse_xml(quote_xml)
        hash = Hash.from_xml(quote_xml)['quote']
        quote = Temando::Quote.new

        quote.total_price = BigDecimal.new(hash['totalPrice'])
        quote.base_price  = BigDecimal.new(hash['basePrice'])
        quote.tax         = BigDecimal.new(hash['tax'])
        quote.currency    = hash['currency']

        quote.name        = hash['deliveryMethod']

        quote.minimum_eta = hash['etaFrom'].to_i
        quote.maximum_eta = hash['etaTo'].to_i
        quote.guaranteed_eta = (hash['guaranteedEta'] == 'Y')

        quote.carrier_id  = hash['carrier']['id']

        quote
      end
    end
  end
end
