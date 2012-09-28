module Temando
  # A Quote is a representation of the shipping quote provided by one of
  # Temando's suppliers.
  class Quote
    FIELDS = %w( total_price tax currency minimum_eta maximum_eta )
    FIELDS.each { |x| attr x.intern, true }
  end
end
