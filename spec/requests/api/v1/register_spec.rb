require 'rails_helper'

describe "Account Creation (User Registration) Endpoint" do
  describe 'good request' do
    before(:each) do
      request_body = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }
      headers = {
        'CONTENT_TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }
      post '/api/v1/users', params: request_body.to_json, headers: headers
    end
  
    it "gets back a good response" do
      expect(response).to have_http_status(201)
    end
  
    it "response includes the api key for the new user" do
      response_body = JSON.parse(response.body, symbolize_names: true)
  
      expect(User.count).to eq(1)
      expect(User.first.api_key).to eq(response_body[:api_key])
    end
  end

  describe 'bad requests' do
    # before(:each) do
    #   request_body = {
    #     "email": "whatever@example.com",
    #     "password": "password",
    #     "password_confirmation": "password"
    #   }
    #   headers = {
    #     'CONTENT_TYPE' => 'application/json',
    #     'ACCEPT' => 'application/json'
    #   }
    #   post '/api/v1/users', params: request_body.to_json, headers: headers
    # end
  
    # it "gets back a good response" do
    #   expect(response).to have_http_status(201)
    # end
  
    # it "response includes the api key for the new user" do
    #   response_body = JSON.parse(response.body, symbolize_names: true)
  
    #   expect(User.count).to eq(1)
    #   expect(User.first.api_key).to eq(response_body[:api_key])
    # end
  end
end
