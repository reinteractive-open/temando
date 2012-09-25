module Temando
  # Temando::Request represents a request for a quotation from the
  # Temando API.
  #
  # It is used to construct the parameters for a quotation, send them
  # off to the API and return the available quotes.
  #
  # Example:
  #   request = Temando::Request.new
  #
  #   # Add the items to be shipped
  #   request.items << Temando::Item::GeneralGoods.new(...)
  #   request.items << Temando::Item::GeneralGoods.new(...)
  #
  #   # Add the details for the actual shipment method and its locations
  #   anywhere = Temando::Delivery::DoorToDoor.new
  #   anywhere.origin      = Temando::Location.new(...)
  #   anywhere.destination = Temando::Location.new(...)
  #
  #   # Ask the server for the quotes
  #   quotes = request.quotes_for(anywhere)
  #
  #   quotes.first # => #<Temando::Quote>
  class Request

    attr_reader :items

    def initialize
      @items = []
    end

    def items=(new_items)
      raise ArgumentError, "Only Temando::Item subclasses can be shipped" unless new_items.all? { |x| x.is_a?(Temando::Item::Base) }
    end

  end
end
