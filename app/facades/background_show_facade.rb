class BackgroundShowFacade
  # TODO: delete attr_reader
  attr_reader :location_string

  def initialize(location_string)
    @location_string = location_string
  end

  def image_url
    image = Image.find_by(title: @location_string.downcase)
    if image
      image.url
    else
      image = Image.create(
        title: @location_string, 
        url: flickr_api.image_url
      )
      image.url
    end
  end

  # TODO: uncomment out
  # private

  def flickr_api
    parameters = { location_string: @location_string }
    @flickr_api ||= ApiService::Flickr.new(parameters)
  end
end
