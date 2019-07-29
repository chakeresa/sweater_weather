class Api::V1::ForecastsController < ApplicationController
  def show
    serializer = ForecastShowSerializer.new(params[:location])
    render json: serializer.full_response
  end
end
