require 'net/http'
require 'json'

class WeatherService
  def self.call(lat:, lon:)
    uri = URI("https://api.open-meteo.com/v1/forecast?latitude=#{lat}&longitude=#{lon}&daily=temperature_2m_max,temperature_2m_min&timezone=auto")
    data = Net::HTTP.get(uri)
    response = JSON.parse(data)

    times = response["daily"]["time"]
    maxes = response["daily"]["temperature_2m_max"]
    mins = response["daily"]["temperature_2m_min"]

 
    forecast = times.zip(maxes, mins).map do |date, max, min| 
      { date: date, max: max, min: min }
    end

    return forecast
  end
end