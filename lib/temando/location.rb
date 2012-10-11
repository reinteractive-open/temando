module Temando
  # A Temando::Location represents address and contact details for
  # pickup or delivery of a shipment.
  class Location
    attr_accessor :country, :postcode, :suburb, :contact, :state, :street, :phone1, :phone2, :email, :company, :fax

    def initialize(attributes={})
      attributes.each do |key, value|
        self.send("#{key}=".intern, value)
      end
    end
  end
end
