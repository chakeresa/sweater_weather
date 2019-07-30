class Api::V1::ForecastsController < ApplicationController
  def show
    location = params[:location]
    facade = Rails.cache.fetch("forecasts/#{location}", expires_in: 1.minutes) do
      ForecastShowFacade.new(location)
    end
    render json: ForecastSerializer.new(facade).full_response
  end
end
