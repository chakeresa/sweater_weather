require 'rails_helper'

describe "Backgrounds Endpoint" do
  it "response includes the url for an image of the city" do
    VCR.use_cassette('backgrounds_endpoint/url_of_image_for_city', record: :new_episodes) do
      get '/api/v1/backgrounds?location=denver,co'

      expect(response).to be_successful

      data = JSON.parse(response.body, symbolize_names: true)[:data]
      
      expect(data).to have_key(:url)
    end
  end
end
