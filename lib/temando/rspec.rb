# RSpec helpers for Temando.
module Temando
  module RSpecHelpers
    # Stubs the SOAP response data for a get_quotes request for a
    # Temando::Response object.
    def stub_temando_request(request, fixture_content)
      request.should_receive(:dispatch_request).with(anything()).and_return(fixture_content)
    end
  end
end
if defined?(RSpec) then
  RSpec.configure do |c|
    c.include Temando::RSpecHelpers
  end
end
