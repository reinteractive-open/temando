module Temando
  module Item
    # A Temando::Item::Base is a physical item (or a quantity of the
    # same item) which are to be shipped.
    #
    # The Temando API refers to these as "Anythings".
    #
    # We don't ship a Temando::Item::Base itself, but rather its
    # subclasses, Temando::Item::GeneralGoods, Temando::Item::Freight,
    # etc.
    class Base
      attr :length, true
      attr :width, true
      attr :height, true
      attr :weight, true
      attr :quantity, true
      attr :description, true

      def initialize(attributes={})
        attributes.each do |key, value|
          self.send("#{key}=".intern, value)
        end
      end
    end
 end
end
