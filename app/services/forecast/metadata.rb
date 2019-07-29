class Forecast::Metadata < Forecast::Base
  def data
    {
      time: time(epoch),
      date: date(epoch),
      location: location,
      data_source: data_source
    }
  end
  
  private

  def epoch
    @forecast_hash[:currently][:time]
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
