class RestaurantsSerializer
  def initialize(facade)
    @facade = facade
  end

  def full_response
    {
      meta: { location: @facade.destination_city_and_state },
      data: { restaurants: restaurants }
    }
  end
  
  private

  def restaurants
    @facade.restaurants.map do |restaurant|
      {
        name: restaurant.name,
        address: restaurant.address
      }
    end
  end
end
