require 'spec_helper'
require './app/services/google_geocoding_api'
require 'faraday'
require './config/application'

describe GoogleGeocodingApi do
  it 'exists' do
    expect(subject).to be_a(GoogleGeocodingApi)
  end

  it 'initializes with location_string' do
    location_string = 'denver, co'
    service = GoogleGeocodingApi.new({ location_string: location_string })
    expect(service.location_string).to eq(location_string)
  end
  
  it '#geocoding_results returns formatted location and lat/long' do
    location_string = 'denver, co'
    service = GoogleGeocodingApi.new({ location_string: location_string })
    result = service.geocoding_results

    expect(result).to have_key(:results)
    expect(result[:results].first).to have_key(:formatted_address)
    expect(result[:results].first[:geometry][:location]).to have_key(:lat)
    expect(result[:results].first[:geometry][:location]).to have_key(:lng)
  end
end