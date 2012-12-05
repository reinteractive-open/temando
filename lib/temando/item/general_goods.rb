module Temando
  module Item
    # A GeneralGood is a type of item that can be shipped by Temando.
    class GeneralGoods < Temando::Item::Base
      attr_accessor :shipping_packaging, :pallet_type, :pallet_nature

      def initialize(attributes={})
        @shipping_packaging = 'Parcel'
        super
      end

      def shipping_class
        'General Goods'
      end

      def shipping_subclass
        'Household Goods'
      end

      def fragile
        false
      end
    end
  end
end
