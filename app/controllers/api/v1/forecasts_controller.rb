class Api::V1::ForecastsController < ApplicationController
  def show
    parameters = { location_string: params[:location] }
    # TODO: abstract stuff below into a facade
    location_hash = GoogleGeocodingApi.new(parameters).geocoding_results
    formatted_location = location_hash[:results].first[:formatted_address]
    lat_long_hash = location_hash[:results].first[:geometry][:location]
    lat = lat_long_hash[:lat]
    long = lat_long_hash[:lng]
  end
end
