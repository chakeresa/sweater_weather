class ForecastShowFacade
  def initialize(location_string)
    @location_string = location_string
  end

  def full_response
    parameters = {
      api_location_hash: api_location_hash,
      forecast_hash: forecast_hash
    }
    {
      meta: Forecast::Metadata.new(parameters).data,
      data: data
    }
  end

  def data
    parameters = { forecast_hash: forecast_hash }
    {
      currently: Forecast::Current.new(parameters).data,
      daily: Forecast::Daily.new(parameters).data.first(5),
      hourly: Forecast::Hourly.new(parameters).data.first(8)
    }
  end

  private

  def google_geocoding_api
    parameters = { location_string: @location_string }
    @google_geocoding_api ||= GoogleGeocodingApi.new(parameters)
  end
  
  def api_location_hash
    @api_location_hash ||= google_geocoding_api.geocoding_results
  end

  def lat_lng_hash
    @lat_lng_hash ||= api_location_hash[:results].first[:geometry][:location]
  end

  def dark_sky_api
    @dark_sky_api ||= DarkSkyApi.new(lat_lng_hash)
  end

  def forecast_hash
    @forecast_hash ||= dark_sky_api.forecast
  end
end
