require 'spec_helper'

describe Temando::Booking do
  describe ".book" do
    let(:request) { Temando::Request.new }
    let(:quote)   { Temando::Quote.new }
    let(:items)   { [ valid_temando_item ] }
    let(:delivery) { Temando::Delivery::DoorToDoor.new }

    it "dispatches the data in and out from Temando::Api::MakeBookingByRequest" do
      format = mock(Temando::Api::MakeBookingByRequest)
      Temando::Api::MakeBookingByRequest.should_receive(:new).with(any_args()).and_return(format)
      format.should_receive(:request_xml).and_return('REQUEST XML')

      format.should_receive(:parse_response).with('RESPONSE XML').and_return(Temando::Booking.new)
      subject.client.should_receive(:dispatch).with('REQUEST XML').and_return('RESPONSE XML')

      subject.quote = quote
      subject.items = items
      subject.delivery = delivery

      subject.book.should be_true
    end
  end
end
