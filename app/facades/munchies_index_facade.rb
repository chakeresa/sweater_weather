class MunchiesIndexFacade
  def initialize(parameters = {})
    @origin = parameters[:origin]
    @destination = parameters[:destination]
    @food = parameters[:food]
  end

  def full_response
    # TODO
    arrival_epoch
    require 'pry'; binding.pry
  #   parameters = {
  #     api_location_hash: api_location_hash,
  #     forecast_hash: forecast_hash
  #   }
  #   {
  #     meta: Forecast::Metadata.new(parameters).data,
  #     data: data
  #   }
  end
  
  private
  
  def google_geocoding_api
    parameters = { origin: @origin, destination: @destination }
    @google_geocoding_api ||= ApiService::GoogleGeocoding.new(parameters)
  end
  
  def api_directions_hash
    @api_directions_hash ||= google_geocoding_api.directions
  end

  def duration_in_seconds
    api_directions_hash[:routes].first[:legs].first[:duration][:value]
  end

  def arrival_epoch
    Time.now.to_i + duration_in_seconds
  end
end
