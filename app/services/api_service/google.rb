class ApiService::Google < ApiService::Base
  attr_reader :location_string, :origin, :destination

  def initialize(parameters = {})
    @location_string = parameters[:location_string]
    @origin = parameters[:origin]
    @destination = parameters[:destination]
  end

  def geocoding_results
    uri_path = '/maps/api/geocode/json'
    location_hash = fetch_json_data(uri_path, address: @location_string)
    check_and_raise_error(location_hash)
    location_hash
  end
  
  def directions
    uri_path = '/maps/api/directions/json'
    parameters = { origin: @origin, destination: @destination }
    directions_hash = fetch_json_data(uri_path, parameters)
    check_and_raise_error(directions_hash)
    directions_hash
  end

  private

  def conn
    @conn ||= Faraday.new(:url => 'https://maps.googleapis.com') do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.params['key'] = ENV['GOOGLE_MAPS_API_KEY']
    end
  end

  def check_and_raise_error(response)
    error_message = response[:error_message]
    raise "#{self.class} error: #{error_message}" if error_message
  end
end
