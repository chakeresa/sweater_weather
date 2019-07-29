class Forecast::Base
  def initialize(parameters = {})
    @api_location_hash = parameters[:api_location_hash]
    @forecast_hash = parameters[:forecast_hash]
  end

  def utc_offset
    @forecast_hash[:offset]
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
  
  def uv_intensity(uv_index_number)
    case uv_index_number
    when 0.000..2.999
      'low'
    when 3.000..5.999
      'moderate'
    when 6.000..7.999
      'high'
    when 8.000..10.999
      'very high'
    else
      'extreme'
    end
  end
  
  private
  
    def datetime(epoch)
      Time.at(epoch).in_time_zone(utc_offset)
    end
end
