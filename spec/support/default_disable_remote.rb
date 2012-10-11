module DefaultDisableRemote
  def stub_remote!
    Temando::Api::SoapClient.any_instance.stub(:perform_request).and_return { raise "External requests are disabled, but have not been correctly stubbed" }
  end
end

RSpec.configure do |config|
  config.include DefaultDisableRemote
  config.before(:each) do
    unless example.metadata[:remote] || (example.metadata[:disable_remote] == false)
      stub_remote!
    end
  end
end
