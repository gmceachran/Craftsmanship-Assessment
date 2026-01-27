require 'net/http'
require 'json'
require 'cgi'

class GeocodingService
  def self.call(query:)
    safe_query = CGI.escape(query)
    uri = URI("https://geocode.xyz/#{safe_query}?json=1")
    data = Net::HTTP.get(uri)
    response = JSON.parse(data)
    Rails.logger.info(response)

    lat = response["latt"]
    lon = response["longt"]
    label = response["standard"] && response["standard"]["city"]

    throttled = "Throttled! See geocode.xyz/pricing"

    if lat.to_s.include?(throttled) || lon.to_s.include?(throttled)
      return { rate_limited: true }
    elsif lat.blank? || lon.blank? || lat.to_f == 0.0 || lon.to_f == 0.0
      return { no_value: true }
    end
    return { lat: lat.to_f, lon: lon.to_f, label: label }
  end
end