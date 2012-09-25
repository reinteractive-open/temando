require 'nokogiri'

module Temando
  module Api
    # Provides the low-level SOAP formatting functionality.
    class Base

      TEMANDO_NAMESPACE = "http://api.temando.com/schema/2009_06/server.xsd"

      def soap_boilerplate(&block)
        data = Nokogiri::XML::Builder.new do |xml|
          xml.Envelope("xmlns:soapenv" => "http://schemas.xmlsoap.org/soap/envelope/",
                                   "xmlns:xsd" => "http://www.w3.org/2001/XMLSchema",
                                   "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance") do

            # Ensure that the "Envelope" namespace absolutely must be soapenv, otherwise we will get soap:VersionMismatch errors
            xml.parent.namespace = xml.parent.namespace_definitions.find { |x| x.prefix == 'soapenv' }
            xml['soapenv'].Header do
              xml.Security("xmlns:wsse" => "http://schemas.xmlsoap.org/ws/2002/04/secext") do
                xml.parent.namespace = xml.parent.namespace_definitions.find { |x| x.prefix == 'wsse' }
                xml['wsse'].UsernameToken do
                  xml['wsse'].Username 'username'
                  xml['wsse'].Password 'password'
                end
              end
            end
            xml['soapenv'].Body(&block)
          end
        end

        data.to_xml(:indent => 2, :encoding => 'UTF-8')
      end

    end
  end
end
