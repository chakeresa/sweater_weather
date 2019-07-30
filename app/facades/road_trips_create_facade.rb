class RoadTripsCreateFacade
  include Directionable

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

  # def flickr_api
  #   parameters = { location_string: @location_string }
  #   @flickr_api ||= ApiService::Flickr.new(parameters)
  # end
end
