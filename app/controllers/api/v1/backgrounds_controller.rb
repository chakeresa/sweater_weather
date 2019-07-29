class Api::V1::BackgroundsController < ApplicationController
  def show
    serializer = BackgroundShowSerializer.new(params[:location])
    render json: serializer.full_response
  end
end
