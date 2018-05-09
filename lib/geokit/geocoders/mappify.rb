require "geokit"
require "geokit/geocoders"
require "monkeypatch/geokit/net_adapter/net_http"
require "monkeypatch/geokit/geocoders"

module Geokit
  module Geocoders
    class MappifyGeocoder < Geocoder
      config :api_key

      private

      def self.do_geocode(address, options = {})
        payload = {streetAddress: address}
        payload[:apiKey] = api_key
        process(:json, "https://mappify.io/api/rpc/address/geocode/", payload: payload)
      end

      STATE_NAMES = {
        "ACT" => "Australian Capital Territory",
        "NSW" => "New South Wales",
        "NT"  => "Northern Territory",
        "QLD" => "Queensland",
        "SA"  => "South Australia",
        "TAS" => "Tasmania",
        "VIC" => "Victoria",
        "WA"  => "Western Australia"
      }

      def self.parse_json(json)
        addr = json["result"]
        loc = new_loc
        loc.success = true
        loc.street_number = [addr["numberFirst"], addr["numberLast"]].compact.join("-")
        loc.street_name = titleize([addr["streetName"], addr["streetType"]].compact.join(" "))
        loc.instance_variable_set(:@street_address, [loc.street_number, loc.street_name].compact.join(" "))
        loc.city = titleize(addr["suburb"])
        loc.state_code = addr["state"]
        loc.state_name = STATE_NAMES[addr["state"]]
        loc.zip = addr["postCode"]
        loc.country_code = "AU"
        loc.country = "Australia"
        loc.full_address = [loc.street_address, [loc.city, loc.state_code, loc.zip].compact.join(" "), loc.country].compact.join(", ")
        loc.precision = "building"
        loc.lat, loc.lng = addr["location"]["lat"], addr["location"]["lon"]
        loc
      end

      def self.titleize(something)
        Geokit::Inflector.titleize(something)
      end
    end
  end
end
