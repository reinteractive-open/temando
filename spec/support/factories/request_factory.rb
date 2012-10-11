module RequestFactory
  def valid_temando_request
    request = Temando::Request.new
    request.items << valid_temando_item

    request
  end
end

RSpec.configure do |c|
  c.include RequestFactory
end
