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
      def initialize(attributes={})
      end
    end
 end
end
