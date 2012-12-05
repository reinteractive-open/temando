module Temando::Api
  module Entities
    class Anything
      def initialize(anything)
        @anything = anything
      end

      def weight_units
        if @anything.weight < 9.5 then
          'Grams'
        else
          'Kilograms'
        end
      end

      def converted_weight
        if weight_units == 'Grams' then
          (@anything.weight * 1000).ceil
        else
          @anything.weight.ceil
        end
      end

      def build_xml(xml)
        xml.anything do
          xml.class_ @anything.shipping_class
          xml.packagingOptimisation(@anything.packaging_optimization.presence || "N")
          xml.subclass @anything.shipping_subclass
          xml.packaging @anything.shipping_packaging
          xml.palletType @anything.pallet_type unless @anything.pallet_type.nil?
          xml.palletNature @anything.pallet_nature unless @anything.pallet_nature.nil?
          xml.qualifierFreightGeneralFragile(@anything.fragile ? 'Y' : 'N')
          xml.distanceMeasurementType 'Centimetres'
          xml.weightMeasurementType weight_units
          xml.length((@anything.length.to_f * 100).ceil)
          xml.width((@anything.width.to_f * 100).ceil)
          xml.height((@anything.height.to_f * 100).ceil)
          xml.weight converted_weight
          xml.quantity @anything.quantity
          xml.description @anything.description
        end
      end
    end
  end
end
