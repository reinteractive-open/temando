require 'spec_helper'

describe Temando::Api::Entities::Quote do

  describe ".parse_xml" do
    it "parses a <quote> entity into a Temando::Quote object" do
      xml = Nokogiri::XML(xml_fixture('get_quotes_by_request/response'))
      input_xml = xml.xpath('//quote').first.to_xml

      quote = Temando::Api::Entities::Quote.parse_xml(input_xml)
      quote.should be_a(Temando::Quote)
      quote.total_price.should == 11.00
      quote.tax.should == 1.0
      quote.currency.should == 'AUD'
      quote.minimum_eta.should == 2
      quote.maximum_eta.should == 3
    end
  end

end
