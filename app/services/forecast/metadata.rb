class Forecast::Metadata < Forecast::Base
  def data
    {
      time: current_time,
      date: current_date,
      location: location,
      data_source: data_source
    }
  end
  
  private

  def current_datetime
    epoch = @forecast_hash[:currently][:time]
    Time.at(epoch).in_time_zone(utc_offset)
  end
  
  def current_time
    current_datetime.strftime("%-l:%M %p")
  end
  
  def current_date
    current_datetime.strftime("%-m/%-d")
  end

  def location
    address_hash = @api_location_hash[:results].first[:address_components]
    city = address_hash[-4][:long_name]
    state = address_hash[-2][:short_name]
    country = address_hash[-1][:long_name]
    { city: city, state: state, country: country }
  end

  def data_source
    { message: 'Powered by Dark Sky', link: 'https://darksky.net/poweredby/' }
  end
end
