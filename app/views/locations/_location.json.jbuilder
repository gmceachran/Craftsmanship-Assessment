json.extract! location, :id, :query, :latitude, :longitude, :label, :created_at, :updated_at
json.url location_url(location, format: :json)
