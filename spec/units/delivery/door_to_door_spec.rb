require 'spec_helper'

describe Temando::Delivery::DoorToDoor do

  describe ".origin" do
    it { should respond_to(:origin) }

    it "accepts Temando::Location" do
      lambda { subject.origin = Temando::Location.new }.should_not raise_exception
    end

    it "raises an exception if an unhandled object is appended" do
      lambda { subject.origin = Temando::Item::Base.new }.should raise_exception(ArgumentError)
    end
  end

  describe ".destination" do
    it { should respond_to(:destination) }

    it "accepts Temando::Location" do
      lambda { subject.destination = Temando::Location.new }.should_not raise_exception
    end

    it "raises an exception if an unhandled object is appended" do
      lambda { subject.destination = Temando::Item::Base.new }.should raise_exception(ArgumentError)
    end
  end

end
