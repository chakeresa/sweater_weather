require 'rails_helper'

describe "Backgrounds Endpoint" do
  before(:each) do
    get '/api/v1/backgrounds?location=denver,co'
  end

  it "gets back a good response" do
    expect(response).to be_successful
  end

  it "response includes the url for an image of the city" do
    data = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(data).to have_key(:url)
  end
end
