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
end
