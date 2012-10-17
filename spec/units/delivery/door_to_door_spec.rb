require 'spec_helper'

describe Temando::Delivery::DoorToDoor do

  describe ".origin" do
    it { should respond_to(:origin) }

    it "accepts Temando::Location" do
      lambda { subject.origin = Temando::Location.new }.should_not raise_exception
    end
  end

  describe ".destination" do
    it { should respond_to(:destination) }

    it "accepts Temando::Location" do
      lambda { subject.destination = Temando::Location.new }.should_not raise_exception
    end
  end

end
