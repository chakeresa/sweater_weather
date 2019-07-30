class RoadTripsCreateFacade
  include Directionable
  include Forecastable

  def initialize(parameters)
    @origin = parameters[:origin]
    @destination = parameters[:destination]
  end

  def summary
    forecast_at_destination[:summary]
  end
  
  def temperature
    forecast_at_destination[:temperature]
  end

  def duration
    duration_in_seconds
  end

  private

  def forecast_location
    @destination
  end

  def forecast_at_destination
    forecast_hash(arrival_epoch)[:currently]
  end
end
