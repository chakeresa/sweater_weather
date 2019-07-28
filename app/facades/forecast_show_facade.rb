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
    {
      currently: currently
    }
  end

  def currently
    {
      type: current_api_data[:summary],
      icon: current_api_data[:icon],
      temperature: current_api_data[:temperature],
      feels_like: current_api_data[:apparentTemperature],
      humidity: current_api_data[:humidity],
      visibility: current_api_data[:visibility],
      uv_index_number: current_uv_index,
      uv_index_intensity: intensity(current_uv_index)
    }
  end

  def current_uv_index
    current_api_data[:uvIndex]
  end

  def intensity(uv_index_number)
    case uv_index_number
    when 0.000..2.999
      'low'
    when 3.000..5.999
      'moderate'
    when 6.000..7.999
      'high'
    when 8.000..10.999
      'very high'
    else
      'extreme'
    end
  end

  def current_api_data
    forecast_hash[:currently]
  end

  # day_of_week = Time.at(1564267265).strftime("%A")

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
