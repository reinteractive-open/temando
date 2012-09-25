require 'spec_helper'

describe Temando::Request do

  describe ".items" do
    it { should respond_to(:items) }
  end

end
