module Directionable
  private
  
  def google_directions_api
    parameters = { origin: @origin, destination: @destination }
    @google_directions_api ||= ApiService::Google.new(parameters)
  end
  
  def api_directions_hash
    @api_directions_hash ||= google_directions_api.directions
  end
  
  def duration_in_seconds
    api_directions_hash[:routes].first[:legs].first[:duration][:value]
  end

  def arrival_epoch
    Time.now.to_i + duration_in_seconds
  end
end