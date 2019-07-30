class Api::V1::MunchiesController < ApplicationController
  def index
    facade = MunchiesIndexFacade.new(search_parameters)
    render json: RestaurantsSerializer.new(facade).full_response
  end
  
  def search_parameters
    {
      origin: params[:start],
      destination: params[:end],
      food_type: params[:food]
    }
  end
end
