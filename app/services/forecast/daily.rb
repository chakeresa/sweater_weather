class Forecast::Daily < Forecast::Base
  def data
    @forecast_hash[:daily][:data].map do |api_data_for_day|
      {
        high_temperature: api_data_for_day[:temperatureHigh],
        low_temperature: api_data_for_day[:temperatureLow],
        summary: api_data_for_day[:summary],
        day_of_week: day_of_week(api_data_for_day[:time]),
        type: api_data_for_day[:icon], # TODO
        icon: api_data_for_day[:icon],
        chance_of_precip: api_data_for_day[:precipProbability],
        precip_type: api_data_for_day[:precipType]
      }
    end
  end
end
