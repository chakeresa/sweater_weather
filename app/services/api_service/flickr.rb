class ApiService::Flickr < ApiService::Base
  attr_reader :location_string

  def initialize(parameters = {})
    @location_string = parameters[:location_string]
  end

  def image_url
    farm_id = image_data['farm']
    server_id = image_data['server']
    id = image_data['id']
    secret = image_data['secret']
    "https://farm#{farm_id}.staticflickr.com/#{server_id}/#{id}_#{secret}.jpg"
  end

  private
  
  def conn
    @conn ||= Faraday.new(:url => 'https://api.flickr.com') do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.params['api_key'] = ENV['FLICKR_API_KEY']
    end
  end
  
  def fetch_xml_data(uri_path, params = {})
    response = conn.get uri_path, params
    Hash.from_xml(response.body)
  end
  
  def image_data
    return @image_data if @image_data

    uri_path = '/services/rest'
    Rails.logger.debug "Making Flickr image search API call (#{@location_string})"
    response = fetch_xml_data(uri_path, image_search_params)
    raise 'Bad Flickr API key' if bad_api_key?(response)
    @image_data = response['rsp']['photos']['photo']
  end
  
  def bad_api_key?(response)
    response['rsp']['stat'] != 'ok'
  end
  
  def image_search_params
    {
      method: 'flickr.photos.search',
      text: @location_string,
      sort: 'relevance',
      content_type: 'relevance',
      per_page: 1
    }
  end
end
