module Temando::Api
  module Entities
    class Anything
      def initialize(anything)
        @anything = anything
      end

      def build_xml(xml)
        xml.anything do
          xml.class_ @anything.shipping_class
          xml.subclass @anything.shipping_subclass
          xml.packaging @anything.shipping_packaging
          xml.qualifierFreightGeneralFragile(@anything.fragile ? 'Y' : 'N')
          xml.distanceMeasurementType 'Centimetres'
          xml.weightMeasurementType 'Kilograms'
          xml.length((@anything.length.to_f * 100).ceil)
          xml.width((@anything.width.to_f * 100).ceil)
          xml.height((@anything.height.to_f * 100).ceil)
          xml.weight @anything.weight.ceil
          xml.quantity @anything.quantity
          xml.description @anything.description
        end
      end
    end
  end
end
