class ApiService::Yelp < ApiService::Base
  attr_reader :location, :food_type, :epoch

  def initialize(parameters = {})
    @location = parameters[:location]
    @food_type = parameters[:food_type]
    @epoch = parameters[:epoch]
  end

  def restaurants
    uri_path = '/v3/businesses/search'
    restaurants_hash = Rails.cache.fetch("restaurants/#{caching_params}", expires_in: 5.minutes) do
      Rails.logger.debug "Making Yelp restaurants API call (#{caching_params})"
      restaurants_hash = fetch_json_data(uri_path, restaurant_search_params)
    end
    check_and_raise_error(restaurants_hash)
    restaurants_hash
  end

  private

  def caching_params
    five_minutes = (5 * 60).to_f
    epoch_rounded_to_five_min = (@epoch / five_minutes).round(0) * five_minutes
    "#{@location}-#{@food_type}-#{epoch_rounded_to_five_min}"
  end

  def restaurant_search_params
    {
      location: @location,
      term: @food_type,
      categories: 'food',
      open_at: @epoch
    }
  end

  def conn
    @conn ||= Faraday.new(:url => 'https://api.yelp.com') do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.headers['Authorization'] = "Bearer #{ENV['YELP_API_KEY']}"
    end
  end

  def check_and_raise_error(response)
    error_message = response[:error]
    raise "#{self.class} error: #{error_message}" if error_message
  end
end
