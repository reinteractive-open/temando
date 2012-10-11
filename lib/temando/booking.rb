module Temando
  # A Booking is a representation of an accepted shipping quote provided by one of
  # Temando's suppliers.
  class Booking
    attr_accessor :request_id, :number, :consignment_number, :manifest_number
  end
end
