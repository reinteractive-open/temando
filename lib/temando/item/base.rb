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

      attr_accessor :length, :width, :height, :weight, :quantity, :description, :packaging_optimization

      validates_numericality_of :length, :width, :height
      validates_numericality_of :quantity, :greater_than => 0, :only_integer => true

      # @param [Hash] attributes to initialize Item with
      # @option attributes [String] :length Length in meters (mandatory)
      # @option attributes [String] :width Width in meters (mandatory)
      # @option attributes [String] :height Height in meters (mandatory)
      # @option attributes [String] :quantity Number of items (mandatory)
      # @option attributes [String] :description Further details of the item being sent
      # @option attributes [String] :packaging_optimization Whether the supplied item details should be used to find an optimal packaging soluation. This option will only work if predefined packaging types have been stored for the user
      def initialize(attributes={})
        attributes.each do |key, value|
          self.send("#{key}=".intern, value)
        end
      end
    end
 end
end
