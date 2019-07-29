class Forecast::Current < Forecast::Base
  def data
    {
      type: current_api_data[:summary],
      icon: current_api_data[:icon],
      temperature: current_api_data[:temperature],
      feels_like: current_api_data[:apparentTemperature],
      humidity: current_api_data[:humidity],
      visibility: current_api_data[:visibility],
      uv_index_number: current_uv_index,
      uv_index_intensity: uv_intensity(current_uv_index)
    }
  end
  
  private

  def current_api_data
    @current_api_data ||= @forecast_hash[:currently]
  end

  def current_uv_index
    current_api_data[:uvIndex]
  end
end
