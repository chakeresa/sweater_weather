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
    
    it "gets back a good response" do
      post '/api/v1/road_trip', params: @request_body.to_json, headers: @headers
      expect(response).to have_http_status(200)
    end
  
    # it "response includes the api key for the logged-in user" do
    #   response_body = JSON.parse(response.body, symbolize_names: true)
  
    #   expect(response_body[:api_key]).to_not be_nil
    #   expect(@user.api_key).to eq(response_body[:api_key])
    # end
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
