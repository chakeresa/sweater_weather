require 'spec_helper'
require './app/services/google_geocoding_api'

describe GoogleGeocodingApi do
  it 'exists' do
    expect(subject).to be_a(GoogleGeocodingApi)
  end

  it 'initializes with location_string' do
    location_string = 'denver, co'
    service = GoogleGeocodingApi.new({ location_string: location_string })
    expect(service.location_string).to eq(location_string)
  end
end
