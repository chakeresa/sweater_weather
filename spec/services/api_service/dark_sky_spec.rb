require 'rails_helper'

describe ApiService::DarkSky do
  it 'exists' do
    expect(subject).to be_a(ApiService::DarkSky)
  end

  it 'initializes with location_string' do
    lat_lng_hash = { lat: 37.8267, lng: -122.4233 }
    service = ApiService::DarkSky.new(lat_lng_hash)
    
    expect(service.lat).to eq(lat_lng_hash[:lat])
    expect(service.long).to eq(lat_lng_hash[:lng])
  end
  
  it '#forecast returns forecasted data' do
    VCR.use_cassette('api_service/dark_sky/forecast', record: :new_episodes) do
      lat_lng_hash = { lat: 37.8267, lng: -122.4233 }
      service = ApiService::DarkSky.new(lat_lng_hash)
      result = service.forecast
      
      expect(result).to have_key(:offset) # UTC offset
      
      expect(result[:currently]).to have_key(:time)
      expect(result[:currently]).to have_key(:summary)
      expect(result[:currently]).to have_key(:icon)
      expect(result[:currently]).to have_key(:temperature)
      expect(result[:currently]).to have_key(:apparentTemperature)
      expect(result[:currently]).to have_key(:humidity)
      expect(result[:currently]).to have_key(:visibility)
      expect(result[:currently]).to have_key(:uvIndex)
      
      expect(result[:hourly][:data].count).to be >= 8
      expect(result[:hourly][:data].first).to have_key(:time)
      expect(result[:hourly][:data].first).to have_key(:icon)
      expect(result[:hourly][:data].first).to have_key(:temperature)
      
      expect(result[:daily][:data].count).to be >= 5
      expect(result[:daily][:data].first).to have_key(:time)
      expect(result[:daily][:data].first).to have_key(:icon)
      expect(result[:daily][:data].first).to have_key(:summary)
      # TODO: delete precipType from here & serializer?
      # The API is not including it on Monday
      # expect(result[:daily][:data].first).to have_key(:precipType)
      expect(result[:daily][:data].first).to have_key(:precipProbability)
      expect(result[:daily][:data].first).to have_key(:temperatureHigh)
      expect(result[:daily][:data].first).to have_key(:temperatureLow)
    end
  end
  
  it '#forecast raises an error if the API response is bad' do
    VCR.use_cassette('api_service/dark_sky/error_on_bad_api_response', record: :new_episodes) do
      lat_lng_hash = { lat: 37.8267, lng: -122.4233 }
      service = ApiService::DarkSky.new(lat_lng_hash)

      stub_const('ENV', {'DARK_SKY_API_KEY' => 'blah'})

      expect { service.forecast }.to raise_error('ApiService::DarkSky error: permission denied')
    end
  end
end
