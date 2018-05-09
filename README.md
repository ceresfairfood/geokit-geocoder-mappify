# Geokit::Geocoder::Mappify

This is a gem to allow Geokit to work with the API from [mappify.io](https://mappify.io). It monkey-patches the Geokit code to allow both POST and GET requests.
It currently only supports geocoding. Reverse geocoding may be added at a later date

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'geokit-geocoder-mappify', github: 'ceresfairfood/geokit-geocoder-mappify'
```

And then execute:

    $ bundle

## Configuration

The geocoder has one configuration parameter `api_key`, that can be set to your Mappify API key. If this is not specified, the anonymous tier will allow up to 100 requests/day

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/geokit-geocoder-mappify.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
