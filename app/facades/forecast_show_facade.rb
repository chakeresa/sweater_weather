class ForecastShowFacade
  def initialize(location_string)
    @location_string = location_string
  end

  def metadata
    Forecast::Metadata.new(metadata_parameters).data
  end

  def currently
    Forecast::Current.new(forecast_parameters).data
  end

  def daily
    Forecast::Daily.new(forecast_parameters).data.first(5)
  end

  def hourly
    Forecast::Hourly.new(forecast_parameters).data.first(8)
  end

  private

  def metadata_parameters
    {
      api_location_hash: api_location_hash,
      forecast_hash: forecast_hash
    }
  end

  def forecast_parameters
    { forecast_hash: forecast_hash }
  end

  def google_api
    parameters = { location_string: @location_string }
    @google_api ||= ApiService::Google.new(parameters)
  end
  
  def api_location_hash
    @api_location_hash ||= google_api.geocoding_results
  end

  def lat_lng_hash
    @lat_lng_hash ||= api_location_hash[:results].first[:geometry][:location]
  end

  def dark_sky_api
    @dark_sky_api ||= ApiService::DarkSky.new(lat_lng_hash)
  end

  def forecast_hash
    @forecast_hash ||= dark_sky_api.forecast
  end
end
