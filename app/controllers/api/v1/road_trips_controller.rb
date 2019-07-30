class Api::V1::RoadTripsController < ApplicationController
  def create
    api_key = params[:api_key]
    return unauthorized('API key must be provided') unless api_key

    user = User.find_by(api_key: api_key)
    if user
      render_response
    else
      unauthorized('Invalid API key')
    end
  end

  private
  
  def render_response
    facade = RoadTripsCreateFacade.new(directions_parameters)
    render json: RoadTripSerializer.new(facade).full_response
  end
  
  def directions_parameters
    origin = params[:origin]
    destination = params[:destination]
    { origin: origin, destination: destination }
  end

  def unauthorized(reason)
    render status: :unauthorized, json: { error: reason }
  end
end
