class ForecastShowFacade
  def initialize(location_string)
    @location_string = location_string
  end

  def formatted_location
    location_hash[:results].first[:formatted_address]
  end
  
  private
  
  def google_geocoding_api
    parameters = { location_string: @location_string }
    @google_geocoding_api ||= GoogleGeocodingApi.new(parameters)
  end
  
  def location_hash
    @location_hash ||= google_geocoding_api.geocoding_results
  end
  
  def lat_long_hash
    @lat_long_hash ||= location_hash[:results].first[:geometry][:location]
    lat = @lat_long_hash[:lat]
    long = @lat_long_hash[:lng]
    require 'pry'; binding.pry
  end
end
