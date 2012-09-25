require 'spec_helper'

describe Temando::Api::GetQuotesByRequest do
  let(:subject) { Temando::Api::GetQuotesByRequest.new([item], delivery) }
  let(:item) { Temando::Item::GeneralGoods.new }
  let(:delivery) { Temando::Delivery::DoorToDoor.new }

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

end
