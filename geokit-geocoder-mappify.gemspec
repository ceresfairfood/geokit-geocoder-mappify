lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "geokit/geocoders/mappify/version"

Gem::Specification.new do |spec|
  spec.name          = "geokit-geocoder-mappify"
  spec.version       = Geokit::Geocoders::Mappify::VERSION
  spec.authors       = ["Andy Palmer"]
  spec.email         = ["andy@riverglide.com"]

  spec.summary       = "Geokit Geocoder for mappify.io (Australian Data Source)"
  spec.homepage      = "https://github.com/ceresfairfood/geokit-geocoder-mappify"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "geokit", "~> 1.11"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.11"
end
