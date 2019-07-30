module Forecastable
  private

  def google_geocoding_api
    parameters = { location_string: forecast_location }
    @google_geocoding_api ||= ApiService::Google.new(parameters)
  end
  
  def api_location_hash
    @api_location_hash ||= google_geocoding_api.geocoding_results
  end

  def lat_lng_hash
    @lat_lng_hash ||= api_location_hash[:results].first[:geometry][:location]
  end

  def dark_sky_api
    @dark_sky_api ||= ApiService::DarkSky.new(lat_lng_hash)
  end

  def forecast_hash(epoch = nil)
    @forecast_hash ||= dark_sky_api.forecast(epoch)
  end
end