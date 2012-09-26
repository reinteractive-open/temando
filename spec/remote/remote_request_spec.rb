require 'spec_helper'

describe Temando::Request, :remote => true do

  describe ".quotes_for" do
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
    let(:request) { subject.items << item; subject }

    it "dispatches the data in and out from Temando::Api::GetQuotesByRequest" do
      item.length = 0.10
      item.width = 0.10
      item.height = 0.10
      item.weight = 1

      response = request.quotes_for(delivery)

      puts response.inspect
    end
  end
end
