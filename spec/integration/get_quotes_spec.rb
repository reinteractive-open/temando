require 'spec_helper'

describe "Get Quotes" do

  it "can get the quotes from Temando" do
    anywhere = Temando::Delivery::DoorToDoor.new
    anywhere.origin = Temando::Location.new(:contact => "Joe Bloggs",
                                            :company => "Bloggs Inc.",
                                            :street => "123 Test Street",
                                            :suburb => "Sydney",
                                            :state => "NSW",
                                            :postcode => "2000",
                                            :phone1 => Faker::PhoneNumber.phone_number,
                                            :email => Faker::Internet.email,
                                            :country => "AU"
                                           )

    anywhere.destination = Temando::Location.new(:contact => "Joe Bloggs",
                                                 :company => "Bloggs Inc.",
                                                 :street => "123 Test Street",
                                                 :suburb => "Sydney",
                                                 :state => "NSW",
                                                 :postcode => "2000",
                                                 :phone1 => Faker::PhoneNumber.phone_number,
                                                 :email => Faker::Internet.email,
                                                 :country => "AU"
                                                )

    request = valid_temando_request

    stub_temando_request(request, xml_fixture('get_quotes_by_request/response'))

    quotes = request.quotes_for(anywhere)
    quotes.should be_a(Array)
    quotes.count.should == 1

    quote = quotes.first
    quote.should be_a(Temando::Quote)
  end
end
