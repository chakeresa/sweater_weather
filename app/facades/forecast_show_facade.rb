class ForecastShowFacade
  def initialize(location_string)
    @location_string = location_string
  end

  def formatted_location
    location_hash[:results].first[:formatted_address]
  end

  def data_source
    { message: 'Powered by Dark Sky', link: 'https://darksky.net/poweredby/' }
  end

  # Time.at(1564267265) returns datetime format
  # day_of_week = Time.at(1564267265).strftime("%A")
  # date = Time.at(1564267265).strftime("%-m/%-d")
  # time = Time.at(1564267265).strftime("%-l:%M %#p")

  # uv index 0-2.9 = low, 3.0-5.9 = moderate, 6.0-7.9 = high, 8.0-10.9 = very high, 11.0+ = exteme
  
  private
  
  def google_geocoding_api
    parameters = { location_string: @location_string }
    @google_geocoding_api ||= GoogleGeocodingApi.new(parameters)
  end
  
  def location_hash
    @location_hash ||= google_geocoding_api.geocoding_results
  end
  
  def lat_lng_hash
    @lat_lng_hash ||= location_hash[:results].first[:geometry][:location]
  end

  def dark_sky_api
    @dark_sky_api ||= DarkSkyApi.new(@lat_lng_hash)
  end
end
