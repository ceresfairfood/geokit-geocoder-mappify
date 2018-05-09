module Geokit
  module Geocoders
    class Geocoder
      def self.process(format, url, *args, payload: nil)
        res = call_geocoder_service(url, payload: payload)
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
    end
  end
end
