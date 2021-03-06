module Temando
  # A Quote is a representation of the shipping quote provided by one of
  # Temando's suppliers.
  class Quote
    attr_accessor :total_price, :tax, :currency, :minimum_eta, :maximum_eta, :name, :base_price, :guaranteed_eta, :carrier_id
  end
end
