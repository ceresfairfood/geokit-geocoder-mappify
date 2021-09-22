# Geokit::Geocoders::Mappify

This is a gem to allow [Geokit](https://github.com/geokit/geokit) to work with the API from [mappify.io](https://mappify.io). It monkey-patches the Geokit code to allow both POST and GET requests, and provide debug logging.
It currently only supports geocoding. Reverse geocoding may be added at a later date.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'geokit-geocoder-mappify', github: 'ceresfairfood/geokit-geocoder-mappify'
```

And then execute:

    $ bundle

## Configuration

The geocoder has one configuration parameter `api_key`, that can be set to your Mappify API key. If this is not specified, the anonymous tier will allow up to 100 requests/day

## Logging

An additional logger option may be passed for debugging, eg:

```ruby
  Geokit::Geocoders::MappifyGeocoder.geocode(
    street_address,
    {
      postCode: address.postcode,
      suburb: address.suburb,
      state: 'VIC',
      logger: logger,
    }
  )

  ...

  def self.logger
    @@my_logger ||= Logger.new("#{Rails.root}/log/geocoding_service.log")
  end
```

This will produce three lines per request, for example:
```
D, [2021-09-22T16:03:00.730908 #80988] DEBUG -- : [MAPPIFY PAYLOAD]  {:streetAddress=>"20 WATER RD", :postCode=>"3072", :suburb=>"PRESTON", :state=>"VIC", :apiKey=>"664602ba-6827-4313-80c6-53b6ef9cac4b"}
D, [2021-09-22T16:03:00.908996 #80988] DEBUG -- : [MAPPIFY RESPONSE] {"type":"streetAddressRecord","result":{"buildingName":null,"numberFirst":20,"numberFirstPrefix":null,"numberFirstSuffix":null,"numberLast":null,"numberLastPrefix":null,"numberLastSuffix":null,"streetName":"WATER","streetType":"ROAD","streetSuffixCode":null,"suburb":"PRESTON","state":"VIC","postCode":"3072","location":{"lat":-37.742924,"lon":145.034029},"streetAddress":"20 WATER ROAD, PRESTON VIC 3072"},"confidence":1}
D, [2021-09-22T16:03:00.910692 #80988] DEBUG -- : [MAPPIFY SUMMARY]  "20 WATER RD, PRESTON VIC 3072","20 WATER ROAD, PRESTON VIC 3072",streetAddressRecord,1,-37.742924,145.034029
```

The summary line can be exported to CSV like so:
```
echo "Sent address, Received streetAddress, type, confidence, lat, lon" > log/geocoding_summary.csv
grep '\[MAPPIFY SUMMARY\]' log/geocoding_service.log | grep -o '".*' | uniq >> log/geocoding_summary.csv
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/geokit-geocoder-mappify.


Tip: for local development you can try adding the following to the gemfile: `path: "/path/to/geokit-geocoder-mappify"`

Or, temporarily configure a Bundler local override: `bundle config local.geokit-geocoder-mappify /path/to/geokit-geocoder-mappify`

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
