require 'rails_helper'

describe "Forecast Endpoint" do
  it "gets back a good response" do
    VCR.use_cassette('forecast_endpoint/good_response', record: :new_episodes) do
      get '/api/v1/forecast?location=denver,co'
      expect(response).to be_successful
    end
  end
  
  it "response includes query details" do
    VCR.use_cassette('forecast_endpoint/metadata', record: :new_episodes) do
      get '/api/v1/forecast?location=denver,co'
      meta = JSON.parse(response.body, symbolize_names: true)[:meta]
      
      expect(meta).to have_key(:time)
      expect(meta).to have_key(:date)
      
      expect(meta[:location]).to have_key(:city)
      expect(meta[:location]).to have_key(:state)
      expect(meta[:location]).to have_key(:country)
      
      expect(meta[:data_source]).to have_key(:message)
      expect(meta[:data_source]).to have_key(:link)
    end
  end
  
  it "response includes current weather info" do
    VCR.use_cassette('forecast_endpoint/currently', record: :new_episodes) do
      get '/api/v1/forecast?location=denver,co'
      json_response = JSON.parse(response.body, symbolize_names: true)
      current_weather = json_response[:data][:currently]
      
      expect(current_weather).to have_key(:type)
      expect(current_weather).to have_key(:icon)
      expect(current_weather).to have_key(:temperature)
      expect(current_weather).to have_key(:feels_like)
      expect(current_weather).to have_key(:humidity)
      expect(current_weather).to have_key(:visibility)
      expect(current_weather).to have_key(:uv_index_number)
      expect(current_weather).to have_key(:uv_index_intensity)
    end
  end
  
  it "response includes daily weather info" do
    VCR.use_cassette('forecast_endpoint/daily', record: :new_episodes) do
      get '/api/v1/forecast?location=denver,co'
      json_response = JSON.parse(response.body, symbolize_names: true)
      daily_weather = json_response[:data][:daily]
      
      expect(daily_weather).to be_an(Array)
      expect(daily_weather.count).to eq(5)
      
      expect(daily_weather.first).to have_key(:high_temperature)
      expect(daily_weather.first).to have_key(:low_temperature)
      expect(daily_weather.first).to have_key(:summary)
      expect(daily_weather.first).to have_key(:day_of_week)
      expect(daily_weather.first).to have_key(:type)
      expect(daily_weather.first).to have_key(:icon)
      expect(daily_weather.first).to have_key(:chance_of_precip)
      expect(daily_weather.first).to have_key(:precip_type)
    end
  end
  
  it "response includes hourly weather info" do
    VCR.use_cassette('forecast_endpoint/hourly', record: :new_episodes) do
      get '/api/v1/forecast?location=denver,co'
      json_response = JSON.parse(response.body, symbolize_names: true)
      hourly_weather = json_response[:data][:hourly]
      
      expect(hourly_weather).to be_an(Array)
      expect(hourly_weather.count).to eq(8)
      
      expect(hourly_weather.first).to have_key(:time) # e.g. 11 PM
      expect(hourly_weather.first).to have_key(:temperature)
    end
  end
end
