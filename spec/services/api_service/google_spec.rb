require 'rails_helper'

describe ApiService::Google do
  it 'exists' do
    expect(subject).to be_a(ApiService::Google)
  end

  it 'initializes with location_string, origin, and/or destination' do
    location_string = 'denver, co'
    service1 = ApiService::Google.new({ location_string: location_string })
    expect(service1.location_string).to eq(location_string)

    origin = 'denver, co'
    destination = 'pueblo, co'
    service2 = ApiService::Google.new({ origin: origin, destination: destination })
    expect(service2.origin).to eq(origin)
    expect(service2.destination).to eq(destination)
  end
  
  it '#geocoding_results returns formatted location and lat/long' do
    VCR.use_cassette('api_service/google/geocoding_results', record: :new_episodes) do
      location_string = 'denver, co'
      service = ApiService::Google.new({ location_string: location_string })
      result = service.geocoding_results
      
      expect(result).to have_key(:results)
      expect(result[:results].first).to have_key(:formatted_address)
      expect(result[:results].first[:geometry][:location]).to have_key(:lat)
      expect(result[:results].first[:geometry][:location]).to have_key(:lng)
    end
  end
  
  it '#geocoding_results raises an error if the API response is bad' do
    VCR.use_cassette('api_service/google/error_on_bad_geocoding_api_response', record: :new_episodes) do
      service = ApiService::Google.new({ location_string: 'denver, co' })
      
      stub_const('ENV', {'GOOGLE_MAPS_API_KEY' => 'blah'})
      
      expect { service.geocoding_results }.to raise_error('ApiService::Google error: The provided API key is invalid.')
    end
  end
  
  it '#directions returns directions info from origin to destination' do
    VCR.use_cassette('api_service/google/directions', record: :new_episodes) do
      origin = 'denver, co'
      destination = 'pueblo, co'
      service = ApiService::Google.new({ origin: origin, destination: destination })
      result = service.directions
      
      expect(result[:routes]).to be_an(Array)
      expect(result[:routes].first[:legs]).to be_an(Array)
      expect(result[:routes].first[:legs].first[:duration]).to have_key(:text)
    end
  end
  
  it '#directions raises an error if the API response is bad' do
    VCR.use_cassette('api_service/google/error_on_bad_directions_api_response', record: :new_episodes) do
      origin = 'denver, co'
      destination = 'pueblo, co'
      service = ApiService::Google.new({ origin: origin, destination: destination })
      
      stub_const('ENV', {'GOOGLE_MAPS_API_KEY' => 'blah'})

      expect { service.directions }.to raise_error('ApiService::Google error: The provided API key is invalid.')
    end
  end
end
