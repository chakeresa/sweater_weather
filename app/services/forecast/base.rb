class Forecast::Base
  def initialize(parameters = {})
    @api_location_hash = parameters[:api_location_hash]
    @forecast_hash = parameters[:forecast_hash]
  end

  private

  def utc_offset
    @forecast_hash[:offset]
  end

  def datetime(epoch)
    Time.at(epoch).in_time_zone(utc_offset)
  end

  def time(epoch)
    datetime(epoch).strftime("%-l:%M %p")
  end
  
  def hour(epoch)
    datetime(epoch).strftime("%-l %p")
  end

  def date(epoch)
    datetime(epoch).strftime("%-m/%-d")
  end

  def day_of_week(epoch)
    datetime(epoch).strftime("%A")
  end
end
