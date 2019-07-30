require 'rails_helper'

describe "Munchies Endpoint" do
  before(:each) do
    mock_time = Time.parse('2019-07-30 11:45:00 -0600')
    allow(Time).to receive(:now).and_return(mock_time)
  end

  describe 'good request' do
    it "gets back a good response" do
      VCR.use_cassette('munchies_endpoint/good_response', record: :new_episodes) do
        get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese'
        expect(response).to be_successful
      end
    end
    
    it "returns the endpoint city & state" do
      VCR.use_cassette('munchies_endpoint/city_and_state', record: :new_episodes) do
        get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese'
        meta = JSON.parse(response.body, symbolize_names: true)[:meta]
        
        expect(meta[:location]).to have_key(:city)
        expect(meta[:location]).to have_key(:state)
      end
    end
    
    it 'returns info for 3 restaurants that will be open upon arrival at the destination' do
      VCR.use_cassette('munchies_endpoint/restaurants_open_upon_arrival', record: :new_episodes) do
        get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese'
        json_response = JSON.parse(response.body, symbolize_names: true)
        restaurants = json_response[:data][:restaurants]
        
        expect(restaurants).to be_an(Array)
        expect(restaurants.count).to eq(3)
        expect(restaurants.first).to have_key(:name)
        expect(restaurants.first).to have_key(:address)
      end
    end
  end
  
  describe 'edge cases' do
    it "doesn't error out if the start param is invalid" do
      VCR.use_cassette('munchies_endpoint/invalid_start_param', record: :new_episodes) do
        get '/api/v1/munchies?start=sdfasdfa&end=pueblo,co&food=chinese'
        expect(response).to be_successful
        
        json_response = JSON.parse(response.body, symbolize_names: true)
        restaurants = json_response[:data][:restaurants]
        
        expect(restaurants).to eq([])
      end
    end
    
    it "doesn't error out if the end param is invalid" do
      VCR.use_cassette('munchies_endpoint/invalid_end_param', record: :new_episodes) do
        get '/api/v1/munchies?start=denver,co&end=lsdkjfaj&food=chinese'
        expect(response).to be_successful
        
        json_response = JSON.parse(response.body, symbolize_names: true)
        restaurants = json_response[:data][:restaurants]
        
        expect(restaurants).to eq([])
      end
    end
    
    it "doesn't error out if the food param is invalid" do
      VCR.use_cassette('munchies_endpoint/invalid_food_param', record: :new_episodes) do
        get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=sadfasfsdf'
        expect(response).to be_successful
        
        json_response = JSON.parse(response.body, symbolize_names: true)
        restaurants = json_response[:data][:restaurants]
        
        expect(restaurants).to eq([])
      end
    end
    
    it "doesn't error out if the start and end params are in different timezones" do
      VCR.use_cassette('munchies_endpoint/across_time_zones', record: :new_episodes) do
        get '/api/v1/munchies?start=denver,co&end=columbus,oh&food=coffee'
        expect(response).to be_successful
        
        json_response = JSON.parse(response.body, symbolize_names: true)
        restaurants = json_response[:data][:restaurants]
        
        expect(restaurants.first).to have_key(:name)
      end
    end
    
    it "doesn't error out if no route is found" do
      VCR.use_cassette('munchies_endpoint/no_route_found', record: :new_episodes) do
        get '/api/v1/munchies?start=denver,co&end=hawaii&food=coffee'
        expect(response).to be_successful
    
        json_response = JSON.parse(response.body, symbolize_names: true)
        restaurants = json_response[:data][:restaurants]

        expect(restaurants).to eq([])
      end
    end
  end
end
