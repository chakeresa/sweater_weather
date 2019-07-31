class Api::V1::BackgroundsController < ApplicationController
  def show
    begin
      facade = BackgroundShowFacade.new(params[:location])
      render json: ImageUrlSerializer.new(facade).full_response
    rescue StandardError => e
      if e.message == "No images found by Flickr API"
        render status: 400, json: { error: 'No results' }
      end
    end
  end
end
