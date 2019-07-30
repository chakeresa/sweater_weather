class Api::V1::RoadTripsController < ApplicationController
  def create
    render json: { message: "something"}
  end
end
