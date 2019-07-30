class BackgroundShowFacade
  def initialize(location_string)
    @location_string = location_string
  end

  def image_url
    flickr_api.image_url
  end

  private

  def flickr_api
    parameters = { location_string: @location_string }
    @flickr_api ||= ApiService::Flickr.new(parameters)
  end
end
