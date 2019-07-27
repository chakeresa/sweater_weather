class Api::V1::ForecastsController < ApplicationController
  def show
    ForecastShowFacade.new(params[:location])
    render json: { message: "contents TBD" }
  end
end
