class Api::V1::ForecastsController < ApplicationController
  def show
    facade = ForecastShowFacade.new(params[:location])
    render json: ForecastShowSerializer.new(facade).full_response
  end
end
