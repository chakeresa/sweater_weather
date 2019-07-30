class Api::V1::ForecastsController < ApplicationController
  def show
    facade = ForecastShowFacade.new(params[:location])
    render json: ForecastSerializer.new(facade).full_response
  end
end
