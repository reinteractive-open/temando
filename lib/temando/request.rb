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

    attr_reader :items, :last_request, :last_response

    def initialize
      @items = []
    end

    def items=(new_items)
      raise ArgumentError, "Only Temando::Item::Base subclasses can be shipped" unless new_items.all? { |x| x.is_a?(Temando::Item::Base) }
    end

    def quotes_for(delivery)
      raise ArgumentError, "Expected a Temando::Delivery::Base subclass" unless delivery.is_a?(Temando::Delivery::Base)

      # Construct the request, dispatch it off to the server and return
      # the result.
      formatter = Temando::Api::GetQuotesByRequest.new(@items, delivery)
      formatter.parse_response(dispatch_request(formatter.request_xml))
    end

  private

    def dispatch_request(request_xml)
      # TODO: HTTP POST
      response = ''



      @@service_url = "https://api.temando.com/soapServer.html"

      @last_request = request_xml
      response = Typhoeus::Request.post(@@service_url,
                                        :body => request_xml,
                                        :headers => {'Content-Type' => "text/xml; charset=utf-8"}
                                       )

      process_response(response)
    end

    # Processes the response and decides whether to handle an error or whether to return the content
    def process_response(response)
      @last_response = response

      if response.body =~ /:Fault>/ then
        handle_error(response)
      else
        debug response.body
        return response
      end
    end

    # Parses a soap:Fault error and raises it as a Temando::SoapError
    def handle_error(response)
      xml = Nokogiri::XML(response.body)
      xpath = '/SOAP-ENV:Envelope/SOAP-ENV:Body/SOAP-ENV:Fault//faultstring'
      msg = xml.xpath(xpath).text

      if msg.to_s.strip == '' then
        xpath = '/SOAP-ENV:Envelope/SOAP-ENV:Body/SOAP-ENV:Fault//faultcode'
        msg = xml.xpath(xpath).text
      end

      # It was a real error - raise the exception
      raise Temando::Api::Exceptions::SoapError.new("Error from server: #{msg}", self.last_request, self.last_response)
    end

  end
end
