class RoadTripsCreateFacade
  include Directionable
  include Forecastable

  def initialize(parameters)
    @origin = parameters[:origin]
    @destination = parameters[:destination]
  end

  def summary
    # flickr_api.image_url
  end

  def temperature
    # TODO
  end

  def duration
    duration_in_seconds
  end

  private

  def forecast_location
    @destination
  end
end
