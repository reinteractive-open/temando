require 'spec_helper'

describe "Make Booking By Request" do
  it "can create a booking on Temando" do
    request = valid_temando_request
    quote   = valid_temando_quote

    delivery = Temando::Delivery::DoorToDoor.new
    delivery.origin = Temando::Location.new(:contact => nil,
                                            :company => "ABC Suppliers",
                                            :street => "123 Test Street",
                                            :suburb => "Sydney",
                                            :state => "NSW",
                                            :postcode => "2000",
                                            :phone1 => Faker::PhoneNumber.phone_number,
                                            :email => Faker::Internet.email,
                                            :country => "AU"
                                           )

    delivery.destination = Temando::Location.new(:contact => "Jane Doe",
                                                 :company => nil,
                                                 :street => "2 Recipient Street",
                                                 :suburb => "Sydney",
                                                 :state => "NSW",
                                                 :postcode => "2000",
                                                 :phone1 => "(02) 9333 3333",
                                                 :fax => "(02) 9333 3331",
                                                 :email => "jane.doe@yahoo.com",
                                                 :country => "AU"
                                                )

    stub_temando_request(request, xml_fixture('make_booking_by_request/response'))

    booking = Temando::Booking.new
    booking.quote    = quote
    booking.items    = request.items
    booking.delivery = delivery

    booking.book.should be_true
    booking.should be_a(Temando::Booking)
  end
end
