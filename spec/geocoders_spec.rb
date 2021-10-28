require "spec_helper"

class LoggerMock
  def debug
    yield
  end
end

RSpec.describe Geokit::Geocoders::Geocoder do

  describe "logger" do
    let(:logger) { LoggerMock.new }

    before do
      allow(described_class).to receive(:do_http).and_return(response)
    end

    context "empty response" do
      let(:response) { double(body: '{"result": null}') }

      it "shouldn't raise error on empty response" do
        expect{ described_class.process(:json, "https://example.com/", payload: {logger: logger}) }.not_to raise_error
      end
    end
  end
end
