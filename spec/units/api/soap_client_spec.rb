require 'spec_helper'

describe Temando::Api::SoapClient do

  describe ".dispatch" do
    let(:ok_response)  { r = mock(Typhoeus::Response); r.stub(:body).and_return(xml_fixture('get_quotes_by_request/response')); r }
    let(:bad_response) { r = mock(Typhoeus::Response); r.stub(:body).and_return(xml_fixture('exceptions/failed_auth')); r }

    it "sends a request to the server" do
      Typhoeus::Request.should_receive(:post).and_return(ok_response)

      subject.dispatch('XML')
    end

    it "raises exceptions on soapfault responses" do
      subject.should_receive(:perform_request).and_return(bad_response)
      lambda { subject.dispatch('XML') }.should raise_exception(Temando::Api::Exceptions::SoapError)
    end

    it "returns the XML data on successful responses" do
      subject.should_receive(:perform_request).and_return(ok_response)
      subject.dispatch('XML').should =~ /getQuotesByRequestResponse/
    end
  end

end
