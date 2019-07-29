class MunchiesIndexFacade
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
    (Time.now + duration_in_seconds / (60 * 60).hours).to_i
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

  def destination_city_and_state
    first_restaurant = api_restaurants_hash[:businesses].first
    city = first_restaurant[:location][:city]
    state = first_restaurant[:location][:state]
    { city: city, state: state }
  end
end
