require 'rails_helper'

describe "Munchies Endpoint" do
  before(:each) do
    get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese'
  end
  
  it "gets back a good response" do
    expect(response).to be_successful
  end

  # You will use the Google Directions API: https://developers.google.com/maps/documentation/directions/start in order to find out how long it will take to travel from the two locations, and then using the Yelp API, you will find all of the restaurants matching the cuisine, the example here is Chinese, that WILL BE OPEN at your estimated time of arrival.
  
  # Your API will return the end city, and three restaurants, along with their name and address.
  
  # The Yelp API only accepts time as UNIX time. You can conert a Time object into UNIX time by doing something like this: Time.now.to_i
  # You can find out time in the future using a feature built into Rails' ActiveSupport which will let you do things like this: Time.now + 4.hours (This will ONLY work in Rails and not a pry session run from the command line)
  
  # it "response includes query details" do
  #   meta = JSON.parse(response.body, symbolize_names: true)[:meta]
  
  #   expect(meta).to have_key(:time)
  #   expect(meta).to have_key(:date)
  
  #   expect(meta[:location]).to have_key(:city)
  #   expect(meta[:location]).to have_key(:state)
  #   expect(meta[:location]).to have_key(:country)
  
  #   expect(meta[:data_source]).to have_key(:message)
  #   expect(meta[:data_source]).to have_key(:link)
  # end
  
  # it "response includes current weather info" do
  #   json_response = JSON.parse(response.body, symbolize_names: true)
  #   current_weather = json_response[:data][:currently]
  
  #   expect(current_weather).to have_key(:type)
  #   expect(current_weather).to have_key(:icon)
  #   expect(current_weather).to have_key(:temperature)
  #   expect(current_weather).to have_key(:feels_like)
  #   expect(current_weather).to have_key(:humidity)
  #   expect(current_weather).to have_key(:visibility)
  #   expect(current_weather).to have_key(:uv_index_number)
  #   expect(current_weather).to have_key(:uv_index_intensity)
  # end
end
