class Api::V1::MunchiesController < ApplicationController
  def index
    search_parameters = {
      origin: params[:start],
      destination: params[:end],
      food_type: params[:food]
    }
    serializer = MunchiesIndexSerializer.new(search_parameters)
    render json: serializer.full_response
  end
end
