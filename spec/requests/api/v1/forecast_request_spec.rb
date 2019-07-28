require 'rails_helper'

describe "Forecast Endpoint" do
  before(:each) do
    get '/api/v1/forecast?location=denver,co'
  end

  it "gets back a good response" do
    expect(response).to be_successful
  end

  it "response includes query details" do
    query_details = JSON.parse(response.body, symbolize_names: true)[:meta]
    
    expect(query_details).to have_key(:city_state)
    expect(query_details).to have_key(:country)
    expect(query_details).to have_key(:time)
    expect(query_details).to have_key(:date)
  end
  
  it "response includes current weather info" do
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
  
  it "response includes daily weather info" do
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
  
  it "response includes hourly weather info" do
    json_response = JSON.parse(response.body, symbolize_names: true)
    hourly_weather = json_response[:data][:hourly]
    
    expect(hourly_weather).to be_an(Array)
    expect(hourly_weather.count).to eq(8)
    
    expect(hourly_weather.first).to have_key(:time) # e.g. 11 PM
    expect(hourly_weather.first).to have_key(:temperature)
  end
end
