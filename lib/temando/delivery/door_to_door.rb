module Temando
  module Delivery
    # A Temando::Delivery::DoorToDoor represents the collection of a
    # shipment from physical premises (eg. home or office) and shipping
    # them to other physical premises.
    class DoorToDoor < Temando::Delivery::Base
      def shipping_nature
        'Domestic'
      end

      def shipping_method
        'Door to Door'
      end
    end
  end
end
