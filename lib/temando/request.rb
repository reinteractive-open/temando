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
  #   Ship an item 40cm x 20cm x 30cm that weights 1kg
  #   request.items << Temando::Item::GeneralGoods.new(length: 0.4, height: 0.2, width: 0.3, quantity: 1, weight: 1)
  #
  #   Add the details for the actual shipment method and its locations
  #   anywhere = Temando::Delivery::DoorToDoor.new
  #   anywhere.origin      = Temando::Location.new(suburb: 'South Melbourne', postcode: '3205', country: 'AU')
  #   anywhere.destination = Temando::Location.new(suburb: 'Traralgon', postcode: '3844', country: 'AU')
  #
  #   Ask the server for the quotes
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
