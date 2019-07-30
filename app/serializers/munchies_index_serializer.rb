class MunchiesIndexSerializer
  # TODO: make separate serializer that makes the final hash.
  # OK for the facade to do the logic.

  def initialize(parameters = {})
    @origin = parameters[:origin]
    @destination = parameters[:destination]
    @food_type = parameters[:food_type]
  end

  def full_response
    {
      meta: { location: destination_city_and_state },
      data: { restaurants: restaurants }
    }
  end
  
  private
  
  def google_api
    parameters = { origin: @origin, destination: @destination }
    @google_api ||= ApiService::Google.new(parameters)
  end
  
  def api_directions_hash
    @api_directions_hash ||= google_api.directions
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
      food_type: @food_type,
      epoch: arrival_epoch
    }
    @yelp_api ||= ApiService::Yelp.new(parameters)
  end
  
  def api_restaurants_hash
    begin
      api_restaurants_hash ||= yelp_api.restaurants
    rescue
      { businesses: [] }
    end
  end

  def restaurants
    api_restaurants_hash[:businesses].first(3).map do |restaurant|
      # TODO: make restaurant objects
      {
        name: restaurant[:name],
        address: restaurant[:location][:display_address]
      }
    end
  end

  def destination_city_and_state
    first_restaurant = api_restaurants_hash[:businesses].first
    if first_restaurant
      city = first_restaurant[:location][:city]
      state = first_restaurant[:location][:state]
      { city: city, state: state }
    else
      @destination
    end
  end
end
