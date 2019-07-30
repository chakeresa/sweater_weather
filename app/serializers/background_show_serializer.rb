class BackgroundShowSerializer
  def initialize(facade)
    @facade = facade
  end

  def full_response
    {
      data: {
        url: @facade.image_url
      }
    }
  end
end
