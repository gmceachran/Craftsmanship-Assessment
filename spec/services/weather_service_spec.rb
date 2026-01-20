require 'rails_helper'

RSpec.describe WeatherService do 
  it "returns temperature from API data" do
    fake_json = '{ 
      "daily": {
        "time": ["2026-01-01"],
        "temperature_2m_max": [10.0],
        "temperature_2m_min": [0.0]
      }
    }'

    allow(Net::HTTP).to receive(:get).and_return(fake_json)
    result = WeatherService.call(lat: 1.0, lon: 2.0)
    expect(result.first[:max]).to eq(10.0)
  end
end