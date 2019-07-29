class ApiService::Yelp < ApiService::Base
  # attr_reader :lat, :long

  # def initialize(parameters = {})
  #   @lat = parameters[:lat]
  #   @long = parameters[:lng]
  # end

  # def forecast
  #   uri_path = '/v3/businesses/search'
  #   forecast_hash = fetch_json_data(uri_path, location: something)
  #   raise 'Bad Yelp API key' if forecast_hash[:error]
  #   forecast_hash
  # end

  private

  def conn
    @conn ||= Faraday.new(:url => 'https://api.yelp.com') do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.headers['Authorization'] = "Bearer #{ENV['YELP_API_KEY']}"
    end
  end
end
