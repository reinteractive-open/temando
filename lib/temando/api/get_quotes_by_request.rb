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
          xml.getQuotesByRequest('xmlns:tem' => TEMANDO_NAMESPACE) do
            xml.parent.namespace = xml.parent.namespace_definitions.find { |x| x.prefix == 'tem' }

            xml.anythings do
              xml.parent.namespace = nil
              @items.each do |anything|
                Temando::Api::Entities::Anything.new(anything).build_xml(xml)
              end
            end

            Temando::Api::Entities::Anywhere.new(@delivery).build_xml(xml)

            # TODO: anytime
            # TODO: general
          end
        end
      end

      def parse_response(response_xml)
        response_xml
      end

    end
  end
end
