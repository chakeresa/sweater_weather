require 'rails_helper'

describe "Login (Session Creation) Endpoint" do
  before(:each) do
    @user = create(:user)
  
    @headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
  end

  describe 'good request' do
    before(:each) do
      request_body = {
        "email": @user.email,
        "password": @user.password
      }
      post '/api/v1/sessions', params: request_body.to_json, headers: @headers
    end
  
    it "gets back a good response" do
      expect(response).to have_http_status(200)
    end
  
    it "response includes the api key for the logged-in user" do
      response_body = JSON.parse(response.body, symbolize_names: true)
  
      expect(response_body[:api_key]).to_not be_nil
      expect(@user.api_key).to eq(response_body[:api_key])
    end
  end

  describe 'bad requests' do
    it "missing email" do
      request_body = {
        "password": "password"
      }

      post '/api/v1/sessions', params: request_body.to_json, headers: @headers

      expect(response).to have_http_status(401)

      response_body = JSON.parse(response.body, symbolize_names: true)
      expected_response = { error: "Email can't be blank" }
      expect(response_body).to eq(expected_response)
    end

    it "missing password" do
      request_body = {
        "email": "whatever@example.com"
      }

      post '/api/v1/sessions', params: request_body.to_json, headers: @headers

      expect(response).to have_http_status(401)

      response_body = JSON.parse(response.body, symbolize_names: true)
      expected_response = { error: "Password can't be blank" }
      expect(response_body).to eq(expected_response)
    end
  end
end
