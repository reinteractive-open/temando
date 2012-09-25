require 'spec_helper'

describe "Get Quotes" do

  it "can get the quotes from Temando" do
    request = Temando::Request.new
    request.items << Temando::Item::GeneralGoods.new(:height => 0.10,
                                                     :length => 0.10,
                                                     :width => 0.10,
                                                     :weight => 1,
                                                     :quantity => 1,
                                                     :description => 'Hats'
                                                    )

    anywhere = Temando::Delivery::DoorToDoor.new
    anywhere.origin = Temando::Location.new(:contact => "Joe Bloggs",
                                            :company => "Bloggs Inc.",
                                            :street => "123 Test Street",
                                            :suburb => "Sydney",
                                            :state => "NSW",
                                            :code => "2000",
                                            :phone1 => Faker::PhoneNumber.phone_number,
                                            :email => Faker::Internet.email,
                                            :country => "AU"
                                           )

    anywhere.destination = Temando::Location.new(:contact => "Joe Bloggs",
                                                 :company => "Bloggs Inc.",
                                                 :street => "123 Test Street",
                                                 :suburb => "Sydney",
                                                 :state => "NSW",
                                                 :code => "2000",
                                                 :phone1 => Faker::PhoneNumber.phone_number,
                                                 :email => Faker::Internet.email,
                                                 :country => "AU"
                                                )

    stub_temando_request(request, 'get_quotes_by_request_response')

    quotes = request.quotes_for(anywhere)

    quotes.count.should == 2

    quote = quotes.first
    quote.should be_a(Temando::Quote)
    quote.total_price.should == 11.00
    quote.tax.shuold == 1.0
    quote.currency.should == 'AUD'
    quote.minimum_eta = 3
    quote.maximum_eta = 5
  end
end
