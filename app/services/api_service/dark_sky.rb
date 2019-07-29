class ApiService::DarkSky < ApiService::Base
  attr_reader :lat, :long

  def initialize(parameters = {})
    @lat = parameters[:lat]
    @long = parameters[:lng]
  end

  def forecast
    uri_path = "/forecast/#{ENV['DARK_SKY_API_KEY']}/#{@lat},#{@long}"
    forecast_hash = fetch_json_data(uri_path)
    raise 'Bad Dark Sky API key' if forecast_hash[:error]
    forecast_hash
  end

  private

  def conn
    @conn ||= Faraday.new(:url => 'https://api.darksky.net') do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.params['exclude'] = 'minutely'
    end
  end
end
