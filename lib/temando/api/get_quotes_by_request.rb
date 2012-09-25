module Temando
  module Api
    # Abstracts generating the request for the SOAP API's
    # getQuotesByRequest method, and parsing the response.
    class GetQuotesByRequest < Temando::Api::Base

      def initialize(items, delivery)
        @items = items
        @delivery = delivery
      end

      def request_xml
        soap_boilerplate do |xml|

        end
      end

    end
  end
end
