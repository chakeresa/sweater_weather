class ForecastShowFacade
  include Forecastable

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

  def forecast_location
    @location_string
  end
end
