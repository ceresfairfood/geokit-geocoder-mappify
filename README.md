# Geokit::Geocoders::Mappify

This is a gem to allow Geokit to work with the API from [mappify.io](https://mappify.io). It monkey-patches the Geokit code to allow both POST and GET requests, and provide debug logging. 
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

## Usage

As per GeoKit, but with additional logger option, eg:

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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/geokit-geocoder-mappify.


Tip: for local development you can try adding the following to the gemfile: `path: "/path/to/geokit-geocoder-mappify"`

Or, temporarily configure a Bundler local override: `bundle config local.geokit-geocoder-mappify /path/to/geokit-geocoder-mappify`

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
