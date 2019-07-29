class Forecast::Hourly < Forecast::Base
  def data
    @forecast_hash[:hourly][:data].map do |api_data_for_hour|
      {
        time: hour(api_data_for_hour[:time]),
        temperature: api_data_for_hour[:temperature]
      }
    end
  end
end
