require 'active_support/core_ext/hash/conversions'

module Temando::Api
  module Entities
    # Handles turning a SOAP <ns1:makeBookingByRequestResponse> element into a Temando::Booking and
    # back again.
    class Booking
      def self.parse_xml(booking_xml)
        hash = Hash.from_xml(booking_xml)['makeBookingByRequestResponse']
        booking = Temando::Booking.new

        booking.request_id         = hash['requestId']
        booking.number             = hash['bookingNumber']
        booking.consignment_number = hash['consignmentNumber']
        booking.manifest_number    = hash['manifestNumber']

        booking
      end
    end
  end
end
