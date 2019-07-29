class MunchiesIndexFacade
  def initialize(parameters = {})
    @origin = parameters[:origin]
    @destination = parameters[:destination]
    @food = parameters[:food]
  end

  def full_response
    # TODO
    duration
  #   parameters = {
  #     api_location_hash: api_location_hash,
  #     forecast_hash: forecast_hash
  #   }
  #   {
  #     meta: Forecast::Metadata.new(parameters).data,
  #     data: data
  #   }
  end

  def duration
    api_directions_hash
    require 'pry'; binding.pry
  end

  private

  def google_geocoding_api
    parameters = { origin: @origin, destination: @destination }
    @google_geocoding_api ||= ApiService::GoogleGeocoding.new(parameters)
  end
  
  def api_directions_hash
    @api_directions_hash ||= google_geocoding_api.directions
  end
end
