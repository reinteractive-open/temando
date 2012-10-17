module Temando
  module Api
    # Abstracts generating the request for the SOAP API's
    # getQuotesByRequest method, and parsing the response.
    class GetQuotesByRequest < Temando::Api::Base

      def initialize(items, delivery)
        @items = items
        @delivery = delivery

        @items.each { |item| validate_item(item) }
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
        xml = Nokogiri::XML(response_xml)
        quotes = xml.xpath('//quote').collect do |result|
          Temando::Api::Entities::Quote.parse_xml(result.to_xml)
        end
      end

    private

      def validate_item(item)
        raise ArgumentError, "#{item.inspect} is not valid" unless item.valid?
      end
    end
  end
end
