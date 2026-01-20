require 'net/http'
require 'json'
require 'cgi'

class GeocodingService
  def self.call(query:)
    safe_query = CGI.escape(query)
    uri = URI("https://geocode.xyz/#{safe_query}?json=1")
    data = Net::HTTP.get(uri)
    response = JSON.parse(data)

    lat = response["latt"]
    lon = response["longt"]
    label = response["standard"] && response["standard"]["city"]

    return nil if lat.blank? || lon.blank? || lat.to_f == 0.0 || lon.to_f == 0.0
    return { lat: lat.to_f, lon: lon.to_f, label: label }
  end
end