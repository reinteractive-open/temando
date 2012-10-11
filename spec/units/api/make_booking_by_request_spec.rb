require 'spec_helper'

describe Temando::Api::MakeBookingByRequest do
  let(:subject) { Temando::Api::MakeBookingByRequest.new(quote, [ item ], delivery) }
  let(:quote)   { valid_temando_quote }
  let(:item)    { valid_temando_item(:description => 'Contains hats.', :quantity => 2) }
  let(:origin)  { Temando::Location.new(:contact => nil,
                                        :company => "ABC Suppliers",
                                        :street => "123 Test Street",
                                        :suburb => "Sydney",
                                        :state => "NSW",
                                        :postcode => "2000",
                                        :phone1 => "(02) 9222 2222",
                                        :fax => "(02) 9222 2221",
                                        :email => "vendor@yahoo.com",
                                        :country => "AU"
                                      ) }

  let(:destination) { Temando::Location.new(:contact => "Jane Doe",
                                            :company => nil,
                                            :street => "2 Recipient Street",
                                            :suburb => "Sydney",
                                            :state => "NSW",
                                            :postcode => "2000",
                                            :phone1 => "(02) 9333 3333",
                                            :fax => "(02) 9333 3331",
                                            :email => "jane.doe@yahoo.com",
                                            :country => "AU"
                                      ) }

  let(:delivery) { Temando::Delivery::DoorToDoor.new(origin, destination) }

  describe ".request_xml" do
    it "generates a SOAP request" do
      subject.request_xml.should == xml_fixture('make_booking_by_request/request')
    end
  end

  describe ".parse_response" do
    it "decodes the SOAP response" do
      Temando::Api::Entities::Booking.should_receive(:parse_xml).with(anything()).exactly(:once)
      result = subject.parse_response(xml_fixture('make_booking_by_request/response'))
    end
  end
end
