class Api::V1::MunchiesController < ApplicationController
  def index
    search_parameters = {
      start: params[:start],
      end: params[:end],
      food: params[:food]
    }
    facade = MunchiesIndexFacade.new(search_parameters)
    render json: facade.full_response
  end
end
