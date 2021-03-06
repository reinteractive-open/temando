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
  #
  # Temando authentication details should be set before calling these methods :
  #
  #   Temando::Api::Base.config.username = 'myuser@example.com'
  #   Temando::Api::Base.config.password = 'sekrit'
  class Request

    attr_accessor :items

    def initialize
      @items = []
    end

    def quotes_for(delivery)
      # Construct the request, dispatch it off to the server and return
      # the result.
      formatter = Temando::Api::GetQuotesByRequest.new(@items, delivery)
      response  = client.dispatch(formatter.request_xml)
      formatter.parse_response(response)
    end

    def client
      @client ||= Temando::Api::SoapClient.new
    end
  end
end
