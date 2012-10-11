require 'spec_helper'

describe Temando::Quote do
  describe ".book" do
    let(:subject) { valid_temando_quote }

    it "dispatches the data in and out from Temando::Api::MakeBookingByRequest" do
      format = mock(Temando::Api::MakeBookingByRequest)
      Temando::Api::MakeBookingByRequest.should_receive(:new).with(quote).and_return(format)
      format.should_receive(:request_xml).and_return('REQUEST XML')

      response = [ Temando::Booking.new ]

      format.should_receive(:parse_response).with('RESPONSE XML').and_return(response)
      request.client.should_receive(:dispatch).with('REQUEST XML').and_return('RESPONSE XML')

      request.book.should == response
    end
  end
end
