require 'spec_helper'

describe Temando::Api::GetQuotesByRequest do
  let(:subject) { Temando::Api::GetQuotesByRequest.new([item], delivery) }
  let(:item) { Temando::Item::GeneralGoods.new }
  let(:origin) { Temando::Location.new(:country => 'AU',
                                       :suburb => 'Brisbane',
                                       :postcode => '4000'
                                      ) }
  let(:destination) { Temando::Location.new(:country => 'AU',
                                       :suburb => 'Sydney',
                                       :postcode => '2000'
                                      ) }

  let(:delivery) { Temando::Delivery::DoorToDoor.new(origin, destination) }

  describe ".request_xml" do
    it "generates a SOAP request" do
      item.length = 0.10
      item.width = 0.10
      item.height = 0.10
      item.weight = 1
      item.quantity = 2
      item.description = 'Contains hats.'

      subject.request_xml.should == xml_fixture('get_quotes_by_request/request')
    end
  end

  describe ".parse_response" do
    it "decodes the SOAP response" do
      Temando::Api::Entities::Quote.should_receive(:parse_xml).with(anything()).exactly(:once)
      result = subject.parse_response(xml_fixture('get_quotes_by_request/response'))
    end
  end

end
