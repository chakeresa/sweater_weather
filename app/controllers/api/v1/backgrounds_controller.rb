class Api::V1::BackgroundsController < ApplicationController
  def show
    facade = BackgroundShowFacade.new(params[:location])
    render json: ImageUrlSerializer.new(facade).full_response
  end
end
