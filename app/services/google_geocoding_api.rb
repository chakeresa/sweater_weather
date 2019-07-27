class GoogleGeocodingApi
  attr_reader :location_string
  
  def initialize(parameters =  {})
    @location_string = parameters[:location_string]
  end

  def lat_long
    require 'pry'; binding.pry
    @location_string
    lat, long = 1, 2
  end
end
