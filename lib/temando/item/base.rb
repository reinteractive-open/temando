require 'active_model'

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

      include ActiveModel::Validations

      attr_accessor :length, :width, :height, :weight, :quantity, :description

      validates_numericality_of :length, :width, :height
      validates_numericality_of :quantity, :greater_than => 0, :only_integer => true

      def initialize(attributes={})
        attributes.each do |key, value|
          self.send("#{key}=".intern, value)
        end
      end
    end
 end
end
