module Temando
  module Api
    # Abstracts generating the request for the SOAP API's
    # makeBookingByRequest method, and parsing the response.
    class MakeBookingByRequest < Temando::Api::Base

      def initialize(quote, items, delivery)
        @quote    = quote
        @items    = items
        @delivery = delivery
      end

      def request_xml
        soap_boilerplate do |xml|
          xml.makeBookingByRequest('xmlns:tem' => TEMANDO_NAMESPACE) do
            xml.parent.namespace = xml.parent.namespace_definitions.find { |x| x.prefix == 'tem' }

            xml.anythings do
              xml.parent.namespace = nil
              @items.each do |anything|
                Temando::Api::Entities::Anything.new(anything).build_xml(xml)
              end
            end

            Temando::Api::Entities::Anywhere.new(@delivery).build_xml(xml)

            xml.origin do
              xml.parent.namespace = nil
              xml.description @delivery.origin.company
            end

            Temando::Api::Entities::Location.new(@delivery.destination).build_xml(xml)
            Temando::Api::Entities::Quote.new(@quote).build_xml(xml)

            # TODO: payment
            # TODO: comments
          end
        end
      end

      def parse_response(response_xml)
        xml = Nokogiri::XML(response_xml)
        quotes = xml.xpath('//ns1:makeBookingByRequestResponse', 'ns1' => TEMANDO_NAMESPACE).collect do |result|
          Temando::Api::Entities::Booking.parse_xml(result.to_xml)
        end
      end

    end
  end
end
