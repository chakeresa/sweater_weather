class Api::V1::ForecastsController < ApplicationController
  def show
    ForecastShowFacade.new(params[:location])
  end
end
