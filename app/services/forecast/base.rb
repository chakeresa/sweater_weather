class Forecast::Base
  def initialize(parameters = {})
    @api_location_hash = parameters[:api_location_hash]
    @forecast_hash = parameters[:forecast_hash]
  end

  private

  def utc_offset
    @forecast_hash[:offset]
  end
end
