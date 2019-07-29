require 'rails_helper'

describe "Munchies Endpoint" do
  before(:each) do
    get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese'
  end
  
  it "gets back a good response" do
    expect(response).to be_successful
  end

  it "returns the end city" do
    meta = JSON.parse(response.body, symbolize_names: true)[:meta]

    expect(meta).to have_key(:location)
  end

  it 'returns info for 3 restaurants that will be open upon arrival at the destination' do
    json_response = JSON.parse(response.body, symbolize_names: true)
    restaurants = json_response[:data][:restaurants]

    expect(restaurants).to be_an(Array)
    expect(restaurants.count).to eq(3)
    expect(restaurants.first).to have_key(:name)
    expect(restaurants.first).to have_key(:address)
  end
end
