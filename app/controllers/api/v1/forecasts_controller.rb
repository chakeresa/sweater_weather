class Api::V1::ForecastsController < ApplicationController
  def show
    parameters = { location_string: params[:location] }
    lat, long = GoogleGeocodingApi.new(parameters).lat_long
  end
end
