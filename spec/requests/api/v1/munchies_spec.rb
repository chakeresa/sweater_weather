require 'rails_helper'

describe "Munchies Endpoint" do
  describe 'good request' do
    before(:each) do
      get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese'
    end
    
    it "gets back a good response" do
      expect(response).to be_successful
    end
  
    it "returns the endpoint city & state" do
      meta = JSON.parse(response.body, symbolize_names: true)[:meta]
  
      expect(meta[:location]).to have_key(:city)
      expect(meta[:location]).to have_key(:state)
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

  describe 'edge cases' do
    it "doesn't error out if the start param is invalid" do
      get '/api/v1/munchies?start=sdfasdfa&end=pueblo,co&food=chinese'
      expect(response).to be_successful

      json_response = JSON.parse(response.body, symbolize_names: true)
      restaurants = json_response[:data][:restaurants]

      expect(restaurants).to eq([])
    end

    it "doesn't error out if the end param is invalid" do
      get '/api/v1/munchies?start=denver,co&end=lsdkjfaj&food=chinese'
      expect(response).to be_successful

      json_response = JSON.parse(response.body, symbolize_names: true)
      restaurants = json_response[:data][:restaurants]

      expect(restaurants).to eq([])
    end

    it "doesn't error out if the food param is invalid" do
      get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=sadfasfsdf'
      expect(response).to be_successful

      json_response = JSON.parse(response.body, symbolize_names: true)
      restaurants = json_response[:data][:restaurants]

      expect(restaurants).to eq([])
    end

    it "doesn't error out if the start and end params are in different timezones" do
      get '/api/v1/munchies?start=denver,co&end=columbus,oh&food=coffee'
      expect(response).to be_successful

      json_response = JSON.parse(response.body, symbolize_names: true)
      restaurants = json_response[:data][:restaurants]

      expect(restaurants.first).to have_key(:name)
    end
  end
end
