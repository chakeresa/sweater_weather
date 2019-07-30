class RoadTripSerializer
  def initialize(facade)
    @facade = facade
  end

  def full_response
    {
      data: {
        id: 1,
        type: 'road_trip',
        attributes: attributes
      }
    }
  end

  private

  def attributes
    {
      forecast: {
        summary: @facade.summary,
        temperature: @facade.temperature
      },
      travel_time_seconds: @facade.duration
    }
  end
end
