module Geokit
  module Geocoders
    class Geocoder
      def self.process(format, url, *args, payload: nil)
        logger = payload.delete(:logger)
        logger&.debug { '[MAPPIFY PAYLOAD]  ' + payload.to_s }

        res = call_geocoder_service(url, payload: payload)
        logger&.debug { '[MAPPIFY RESPONSE] ' + res.body }
        logger&.debug { '[MAPPIFY SUMMARY]  ' + log_summary(payload, res.body).to_csv }

        return GeoLoc.new unless net_adapter.success?(res)
        parse format, res.body, *args
      end

      def self.call_geocoder_service(url, payload:)
        Timeout.timeout(Geokit::Geocoders.request_timeout) { return do_http(url, payload: payload) } if Geokit::Geocoders.request_timeout
        do_http(url, payload: payload)
      rescue Timeout::Error
        nil
      end

      def self.do_http(url, payload:)
        payload.nil? ? net_adapter.do_get(url) : net_adapter.do_post(url, payload: payload)
      end

      private

      def self.log_summary(payload, body)
        response = JSON.parse(body)
        [
          "#{payload[:streetAddress]}, #{payload[:suburb]} #{payload[:state]} #{payload[:postCode]}",
          response['result']['streetAddress'],
          response['type'],
          response['confidence'],
          response['result']['location']['lat'],
          response['result']['location']['lon'],
        ]
      end
    end
  end
end
