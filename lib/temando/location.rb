module Temando
  # A Temando::Location represents address and contact details for
  # pickup or delivery of a shipment.
  class Location
    FIELDS = %w( country postcode suburb )

    FIELDS.each { |x| attr x.intern, true }
    def initialize(attributes={})
      attributes.each do |key, value|
        self.send("#{key}=".intern, value)
      end
    end
  end
end
