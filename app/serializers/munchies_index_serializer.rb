class MunchiesIndexSerializer
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
      # TODO: change to restaurant.name, etc after PORO is made
      {
        name: restaurant[:name],
        address: restaurant[:location][:display_address]
      }
    end
  end
end
