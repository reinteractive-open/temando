require 'spec_helper'

describe "Make Booking By Request" do
  it "can create a booking on Temando" do
    quote = valid_temando_quote

    stub_temando_request(request, xml_fixture('make_booking_by_request/response'))

    booking = quote.book
    booking.should be_a(Temando::Booking)
  end
end
