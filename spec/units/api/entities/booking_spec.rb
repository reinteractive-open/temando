require 'spec_helper'

describe Temando::Api::Entities::Booking do

  describe ".parse_xml" do
    it "parses a <ns1:makeBookingByRequestResponse> entity into a Temando::Booking object" do
      xml = Nokogiri::XML(xml_fixture('make_booking_by_request/response'))
      input_xml = xml.xpath('//ns:makeBookingByRequestResponse', 'ns' => Temando::Api::Base::TEMANDO_NAMESPACE).first.to_xml

      booking = Temando::Api::Entities::Booking.parse_xml(input_xml)
      booking.should be_a(Temando::Booking)

      booking.request_id.should         == '100000'
      booking.number.should             == 'XYZ300001'
      booking.consignment_number.should == 'UVW400001'
      booking.manifest_number.should    == 'DEF000001'
    end
  end

end
