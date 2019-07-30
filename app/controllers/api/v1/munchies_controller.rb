class Api::V1::MunchiesController < ApplicationController
  def index
    serializer = MunchiesIndexSerializer.new(search_parameters)
    render json: serializer.full_response
  end
  
  def search_parameters
    {
      origin: params[:start],
      destination: params[:end],
      food_type: params[:food]
    }
  end
end
