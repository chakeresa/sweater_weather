class ForecastShowFacade
  def initialize(location_string)
    @location_string = location_string
  end

  def location_hash
    address_hash = api_location_hash[:results].first[:address_components]
    city = address_hash[-4][:long_name]
    state = address_hash[-2][:short_name]
    country = address_hash[-1][:long_name]
    { city: city, state: state, country: country }
  end

  def data_source
    { message: 'Powered by Dark Sky', link: 'https://darksky.net/poweredby/' }
  end

  def meta
    {
      time: current_time,
      date: current_date,
      location_hash: location_hash,
      data_source: data_source
    }
  end

  def full_response
    {
      meta: meta,
      data: data
    }
  end

  def data
    # TODO
  end

  def current_time
    current_datetime.strftime("%-l:%M %p")
  end
  
  def current_date
    current_datetime.strftime("%-m/%-d")
  end

  def current_datetime
    epoch = forecast_hash[:currently][:time]
    Time.at(epoch).in_time_zone(utc_offset)
  end

  def utc_offset
    forecast_hash[:offset]
  end

  # day_of_week = Time.at(1564267265).strftime("%A")

  # uv index 0-2.9 = low, 3.0-5.9 = moderate, 6.0-7.9 = high, 8.0-10.9 = very high, 11.0+ = exteme
  
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
