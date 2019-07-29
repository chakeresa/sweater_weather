class ApiService::Yelp < ApiService::Base
  attr_reader :location, :food_type, :epoch

  def initialize(parameters = {})
    @location = parameters[:location]
    @food_type = parameters[:food_type]
    @epoch = parameters[:epoch]
  end

  def restaurants
    uri_path = '/v3/businesses/search'
    search_parameters = {
      location: @location,
      term: @food_type,
      categories: 'food',
      open_at: @epoch
    }
    forecast_hash = fetch_json_data(uri_path, search_parameters)
    raise 'Bad Yelp API key' if forecast_hash[:error]
    forecast_hash
  end

  private

  def conn
    @conn ||= Faraday.new(:url => 'https://api.yelp.com') do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.headers['Authorization'] = "Bearer #{ENV['YELP_API_KEY']}"
    end
  end
end
