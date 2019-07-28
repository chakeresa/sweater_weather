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
      uv_index_intensity: intensity(current_uv_index)
    }
  end
  
  private

  def current_api_data
    @current_api_data ||= @forecast_hash[:currently]
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
end
