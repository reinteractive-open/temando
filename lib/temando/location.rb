module Temando
  # A Temando::Location represents address and contact details for
  # pickup or delivery of a shipment.
  class Location
    attr_accessor :country, :postcode, :suburb, :contact, :state, :street, :phone1, :phone2, :email, :company

    # @param [Hash] attributes to initialize Location with
    # @option attributes [String] :suburb Suburb name (mandatory)
    # @option attributes [String] :postcode Postcode (mandatory)
    # @option attributes [String] :country Two letteer ISO3166 code (mandatory)
    # @option attributes [String] :contact Contact Name
    # @option attributes [String] :state State
    # @option attributes [String] :street Street
    # @option attributes [String] :phone1 Contact phone number 1
    # @option attributes [String] :phone2 Contact phone number 1
    # @option attributes [String] :email Contact e-mail address
    # @option attributes [String] :company Contact company
    def initialize(attributes={})
      attributes.each do |key, value|
        self.send("#{key}=".intern, value)
      end
    end
  end
end
