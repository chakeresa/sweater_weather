class ApiService::DarkSky < ApiService::Base
  attr_reader :lat, :long

  def initialize(parameters = {})
    @lat = parameters[:lat]
    @long = parameters[:lng]
  end

  def forecast(epoch = nil)
    forecast_hash = fetch_json_data(uri_path(epoch))
    Rails.logger.debug "Making Dark Sky forecast API call (#{@lat}-#{@long}-#{epoch})"
    check_and_raise_error(forecast_hash)
    forecast_hash
  end

  private

  def uri_path(epoch = nil)
    path = "/forecast/#{ENV['DARK_SKY_API_KEY']}/#{@lat},#{@long}"
    path << ",#{epoch}" if epoch
    path
  end

  def conn
    @conn ||= Faraday.new(:url => 'https://api.darksky.net') do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.params['exclude'] = 'minutely'
    end
  end

  def check_and_raise_error(response)
    error_message = response[:error]
    raise "#{self.class} error: #{error_message}" if error_message
  end
end
