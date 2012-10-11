require "typhoeus"

require "temando/version"

require "temando/location"

require "temando/item/base"
require "temando/item/general_goods"

require "temando/delivery/base"
require "temando/delivery/door_to_door"

require "temando/quote"
require "temando/booking"

require "temando/api/soap_client"
require "temando/api/base"
require "temando/api/entities/anything"
require "temando/api/entities/anywhere"
require "temando/api/entities/quote"
require "temando/api/entities/booking"
require "temando/api/get_quotes_by_request"
require "temando/api/make_booking_by_request"

require "temando/api/exceptions/soap_error"

require "temando/request"

module Temando
end
