module Temando::Api
  module Entities
    class Location
      MAPPINGS = [ [ :contact, :contactName ],
                   [ :company, :description ],
                   :street,
                   :suburb,
                   :state,
                   [ :postcode, :code  ],
                   :country,
                   :phone1,
                   :phone2,
                   :fax,
                   :email
                 ]

      def initialize(element, location)
        @element  = element
        @location = location
      end

      def build_xml(xml)
        xml.send(@element) do
          xml.parent.namespace = nil

          MAPPINGS.each do |definition|
            if definition.is_a?(Array) then
              xml.send(definition[1], @location.send(definition[0]))
            else
              xml.send(definition, @location.send(definition))
            end
          end
        end
      end
    end
  end
end
