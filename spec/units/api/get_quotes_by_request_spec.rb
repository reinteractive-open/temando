require 'spec_helper'

describe Temando::Api::GetQuotesByRequest do
  let(:subject) { Temando::Api::GetQuotesByRequest.new([item], delivery) }
  let(:item) { Temando::Item::GeneralGoods.new }
  let(:delivery) { Temando::Delivery::DoorToDoor.new }

  describe ".request_xml" do
    it "generates a SOAP request" do
      subject.request_xml.should == xml_fixture('get_quotes_by_request/request')
    end
  end

end
