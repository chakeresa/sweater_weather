class MunchiesIndexFacade
  def initialize(parameters = {})
    @origin = parameters[:origin]
    @destination = parameters[:destination]
    @food = parameters[:food]
  end

  def full_response
    {
      meta: { location: @destination },
      data: { restaurants: restaurants }
    }
  end
  
  private
  
  def google_geocoding_api
    parameters = { origin: @origin, destination: @destination }
    @google_geocoding_api ||= ApiService::GoogleGeocoding.new(parameters)
  end
  
  def api_directions_hash
    @api_directions_hash ||= google_geocoding_api.directions
  end

  def duration_in_seconds
    api_directions_hash[:routes].first[:legs].first[:duration][:value]
  end

  def arrival_epoch
    Time.now.to_i + duration_in_seconds
  end

  def yelp_api
    parameters = { 
      location: @destination,
      food_type: @food,
      epoch: arrival_epoch
    }
    @yelp_api ||= ApiService::Yelp.new(parameters)
  end
  
  def api_restaurants_hash
    @api_restaurants_hash ||= yelp_api.restaurants
  end

  def restaurants
    api_restaurants_hash[:businesses].first(3).map do |restaurant|
      {
        name: restaurant[:name],
        address: restaurant[:location][:display_address]
      }
    end
  end
end
