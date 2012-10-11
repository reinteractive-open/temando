module Temando
  # A Booking is a representation of an accepted shipping quote provided by one of
  # Temando's suppliers.
  class Booking
    attr_accessor :request_id, :number, :consignment_number, :manifest_number

    attr_accessor :quote, :items, :delivery

    def book
      # Construct the request, dispatch it off to the server and return
      # the result.
      formatter = Temando::Api::MakeBookingByRequest.new(@quote, @items, @delivery)
      response  = client.dispatch(formatter.request_xml)
      booking = formatter.parse_response(response)

      # TODO: Update my fields

      return true
    end

    def client
      @client ||= Temando::Api::SoapClient.new
    end
  end
end
