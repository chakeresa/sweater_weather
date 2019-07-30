class ForecastShowSerializer
  def initialize(facade)
    @facade = facade
  end

  def full_response
    {
      meta: @facade.metadata,
      data: data
    }
  end

  private

  def data
    {
      currently: @facade.currently,
      daily: @facade.daily,
      hourly: @facade.hourly
    }
  end
end
