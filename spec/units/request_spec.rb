require 'spec_helper'

describe Temando::Request do

  describe ".items" do
    it { should respond_to(:items) }
  end

  describe ".quotes_for" do
    let(:item) { Temando::Item::GeneralGoods.new }
    let(:delivery) { Temando::Delivery::DoorToDoor.new }
    let(:request) { subject.items << item; subject }

    it "raises an exception if the provided argument isn't a Temando::Delivery subclass" do
      lambda { request.quotes_for(item) }.should raise_exception(ArgumentError)
    end

    it "dispatches the data in and out from Temando::Api::GetQuotesByRequest" do
      item.length = 0.10
      item.width = 0.10
      item.height = 0.10
      item.weight = 1

      format = mock(Temando::Api::GetQuotesByRequest)
      Temando::Api::GetQuotesByRequest.should_receive(:new).with([item], delivery).and_return(format)
      format.should_receive(:request_xml).and_return('REQUEST XML')

      response = [ Temando::Quote.new ]

      format.should_receive(:parse_response).with('RESPONSE XML').and_return(response)
      request.client.should_receive(:dispatch).with('REQUEST XML').and_return('RESPONSE XML')

      request.quotes_for(delivery).should == response
    end
  end

  describe ".dispatch_request" do

  end

end
