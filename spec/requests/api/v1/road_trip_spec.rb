require 'rails_helper'

describe "Road Trip Endpoint" do
  before(:each) do
    user = create(:user)
    @api_key = user.api_key
  
    @headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
  end

  describe 'good request' do
    before(:each) do
      @request_body = {
        'origin': 'Denver,CO', 
        'destination': 'Pueblo,CO',
        'api_key': @api_key
      }
    end
    
    it 'gets back a good response' do
      post '/api/v1/road_trip', params: @request_body.to_json, headers: @headers
      expect(response).to have_http_status(200)
    end
    
    it 'response includes the travel time + forecast at the arrival time/location' do
      # If the trip takes x minutes, deliver a forecast (temperature and summary) x minutes in the future, and the estimated travel time.
      post '/api/v1/road_trip', params: @request_body.to_json, headers: @headers
      data = JSON.parse(response.body, symbolize_names: true)[:data]
  
      expect(data).to have_key(:id)
      expect(data).to have_key(:type)

      attributes = data[:attributes]
      
      expect(attributes[:forecast]).to have_key(:temperature)
      expect(attributes[:forecast]).to have_key(:summary)

      expect(attributes).to have_key(:travel_time_seconds)
    end
  end

  describe 'bad requests' do
    it 'missing api_key' do
      request_body = {
        'origin': 'Denver,CO', 
        'destination': 'Pueblo,CO'
      }

      post '/api/v1/road_trip', params: request_body.to_json, headers: @headers

      expect(response).to have_http_status(401)

      response_body = JSON.parse(response.body, symbolize_names: true)
      expected_response = { error: 'API key must be provided' }
      expect(response_body).to eq(expected_response)
    end
    
    it 'invalid api_key' do
      request_body = {
        'origin': 'Denver,CO', 
        'destination': 'Pueblo,CO',
        'api_key': 'jgn983hy48thw9begh98h4539h4'
      }
  
      post '/api/v1/road_trip', params: request_body.to_json, headers: @headers
  
      expect(response).to have_http_status(401)
  
      response_body = JSON.parse(response.body, symbolize_names: true)
      expected_response = { error: 'Invalid API key' }
      expect(response_body).to eq(expected_response)
    end
  end
end
