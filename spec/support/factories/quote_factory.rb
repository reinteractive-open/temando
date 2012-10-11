module QuoteFactory
  def valid_temando_quote(options={})
    Temando::Quote.new({}.merge(options))
  end
end

RSpec.configure do |c|
  c.include QuoteFactory
end
