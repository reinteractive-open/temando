require 'spec_helper'

describe Temando::Item::GeneralGoods do
  let(:valid_item) { valid_temando_item }

  describe ".valid?" do
    it "should be valid" do
      valid_item.should be_valid
    end

    it "is invalid with a blank quantity" do
      valid_item.quantity = nil
      valid_item.should_not be_valid
    end

    it "is invalid with a blank length" do
      valid_item.length = nil
      valid_item.should_not be_valid
    end
  end

  describe ".shipping_packaging" do
    it 'defaults to "Parcel"' do
      valid_item.shipping_packaging.should == 'Parcel'
    end

    it 'can be set and read' do
      valid_item.shipping_packaging = 'Pallet'
      valid_item.shipping_packaging.should == 'Pallet'
    end
  end
end
