# TODO: rename to be just Google
class ApiService::GoogleGeocoding < ApiService::Base
  attr_reader :location_string, :origin, :destination

  def initialize(parameters = {})
    @location_string = parameters[:location_string]
    @origin = parameters[:origin]
    @destination = parameters[:destination]
  end

  def geocoding_results
    uri_path = '/maps/api/geocode/json'
    location_hash = fetch_json_data(uri_path, address: @location_string)
    raise 'Bad Google Maps API key' if location_hash[:error_message]
    location_hash
  end
  
  def directions
    uri_path = '/maps/api/directions/json'
    parameters = { origin: @origin, destination: @destination }
    directions_hash = fetch_json_data(uri_path, parameters)
    # TODO: change exception message be the actual error
    raise 'Bad Google Maps API key' if directions_hash[:error_message]
    directions_hash
    require 'pry'; binding.pry
  end

  private

  def conn
    @conn ||= Faraday.new(:url => 'https://maps.googleapis.com') do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.params['key'] = ENV['GOOGLE_MAPS_API_KEY']
    end
  end
end
