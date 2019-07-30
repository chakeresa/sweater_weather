class RoadTripSerializer
  def initialize(facade)
    @facade = facade
  end

  def full_response
    {
      meta: {
        data_source: data_source
      },
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

  def data_source
    { message: 'Powered by Dark Sky', link: 'https://darksky.net/poweredby/' }
  end
end
