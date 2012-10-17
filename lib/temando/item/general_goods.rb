module Temando
  module Item
    # A GeneralGood is a type of item that can be shipped by Temando.
    class GeneralGoods < Temando::Item::Base
      def shipping_class
        'General Goods'
      end

      def shipping_subclass
        'Household Goods'
      end

      def shipping_packaging
        'Parcel'
      end

      def fragile
        false
      end
    end
   end
end
