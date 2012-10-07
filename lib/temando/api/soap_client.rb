require 'active_support/configurable'

module Temando
  module Api
    class SoapClient
      include ActiveSupport::Configurable

      attr_reader :last_request, :last_response
      config_accessor :service_url

      config.service_url = "https://api.temando.com/soapServer.html"

      def dispatch(request_xml)
        response = ''

        @last_request = request_xml

        process_response(perform_request(request_xml))
      end

    private

      def perform_request(request_xml)
        Typhoeus::Request.post(service_url,
                               :body => request_xml,
                               :headers => {'Content-Type' => "text/xml; charset=utf-8"}
                              )
      end

      # Processes the response and decides whether to handle an error or whether to return the content
      def process_response(response)
        @last_response = response

        if response.body =~ /:Fault>/ then
          handle_error(response)
        else
          response.body
        end
      end

      # Parses a soap:Fault error and raises it as a Temando::SoapError
      def handle_error(response)
        xml = Nokogiri::XML(response.body)
        xpath = '/SOAP-ENV:Envelope/SOAP-ENV:Body/SOAP-ENV:Fault//faultstring'
        msg = xml.xpath(xpath).text

        if msg.to_s.strip == '' then
          xpath = '/SOAP-ENV:Envelope/SOAP-ENV:Body/SOAP-ENV:Fault//faultcode'
          msg = xml.xpath(xpath).text
        end

        # It was a real error - raise the exception
        raise Temando::Api::Exceptions::SoapError.new("Error from server: #{msg}", self.last_request, self.last_response)
      end
    end
  end
end
