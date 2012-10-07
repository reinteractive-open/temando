module Temando
  module Delivery
    # A Temando::Delivery::Base represents ways of shipping
    # items.
    #
    # The Temando API refers to a delivery action as an "Anywhere".
    #
    # This is a base class for the delivery mechanisms,
    # Temando::Delivery::DoorToDoor and Temando::Delivery::DepotToDepot
    class Base
      attr_reader :origin, :destination

      def initialize(origin = nil, destination = nil)
        self.origin = origin
        self.destination = destination
      end

      def origin=(location)
        @origin = location
      end

      def destination=(location)
        @destination = location
      end
    end
 end
end
