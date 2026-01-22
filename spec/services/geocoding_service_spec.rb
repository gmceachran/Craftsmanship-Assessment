require 'rails_helper'

RSpec.describe GeocodingService do
  it "Returns coordinates from query" do
    fake_json = { coords? or query? }

    allow(Net::HTTP).to receive(:get).and_return(fake_json)
    result = GeocodingService.call(query)
  end
end