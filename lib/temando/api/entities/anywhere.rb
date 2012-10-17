module Temando::Api
  module Entities
    class Anywhere
      def initialize(anywhere)
        @anywhere = anywhere
      end

      def build_xml(xml)
        xml.anywhere do
          xml.parent.namespace = nil
          xml.itemNature @anywhere.shipping_nature
          xml.itemMethod @anywhere.shipping_method
          xml.originCountry @anywhere.origin.country
          xml.originCode @anywhere.origin.postcode
          xml.originSuburb @anywhere.origin.suburb
          xml.destinationCountry @anywhere.destination.country
          xml.destinationCode @anywhere.destination.postcode
          xml.destinationSuburb @anywhere.destination.suburb
          xml.destinationIs 'Residence'
          xml.destinationResNotifyBefore 'N'
          xml.destinationResLimitedAccess 'N'
          xml.originIs 'Business'
          xml.originBusNotifyBefore 'Y'
          xml.originBusLimitedAccess 'N'
        end
      end
    end
  end
end
