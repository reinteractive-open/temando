require 'spec_helper'

describe Temando::Api::Entities::Anything do
  let(:item) { valid_temando_item(:description => 'Contains hats.', :quantity => 2) }

  describe ".converted_weight" do
    it "formats large weights as Kilograms" do
      item.weight = 10.2
      entity = Temando::Api::Entities::Anything.new(item)
      entity.converted_weight.should == 11
      entity.weight_units.should == 'Kilograms'
    end

    it "formats medium weights as Grams" do
      item.weight = 9.2
      entity = Temando::Api::Entities::Anything.new(item)
      entity.converted_weight.should == 9200
      entity.weight_units.should == 'Grams'
    end

    it "formats small weights as Grams" do
      item.weight = 0.033
      entity = Temando::Api::Entities::Anything.new(item)
      entity.converted_weight.should == 33
      entity.weight_units.should == 'Grams'
    end
  end
end
