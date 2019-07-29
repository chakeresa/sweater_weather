class ApiService::GoogleGeocoding < ApiService::Base
  attr_reader :location_string

  def initialize(parameters = {})
    @location_string = parameters[:location_string]
  end

  def geocoding_results
    uri_path = '/maps/api/geocode/json'
    location_hash = fetch_data(uri_path, address: @location_string)
    raise 'Bad Google Maps API key' if location_hash[:error_message]
    location_hash
  end

  private

  def conn
    @conn ||= Faraday.new(:url => 'https://maps.googleapis.com') do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.params['key'] = ENV['GOOGLE_MAPS_API_KEY']
    end
  end
end
