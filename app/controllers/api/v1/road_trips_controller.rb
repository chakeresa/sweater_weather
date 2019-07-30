class Api::V1::RoadTripsController < ApplicationController
  def create
    api_key = params[:api_key]
    return unauthorized('API key must be provided') unless api_key

    user = User.find_by(api_key: api_key)
    if user
      render json: { message: "something"}
    else
      unauthorized('Invalid API key')
    end
  end

  private

  def unauthorized(reason)
    render status: :unauthorized, json: { error: reason }
  end
end
