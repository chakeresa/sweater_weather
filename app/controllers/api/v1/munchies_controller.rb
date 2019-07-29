class Api::V1::MunchiesController < ApplicationController
  def index
    search_parameters = {
      origin: params[:start],
      destination: params[:end],
      food_type: params[:food]
    }
    facade = MunchiesIndexFacade.new(search_parameters)
    render json: facade.full_response
  end
end
