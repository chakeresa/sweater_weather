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

  it "doesn't make another API call if the same city has already been searched for" do
    VCR.use_cassette('backgrounds_endpoint/minimize_api_calls', record: :new_episodes) do
      expect(Image.count).to eq(0)

      get '/api/v1/backgrounds?location=denver,co'

      expect(response).to be_successful
      expect(Image.count).to eq(1)

      get '/api/v1/backgrounds?location=DENVER,co'

      expect(response).to be_successful
      expect(Image.count).to eq(1)

      data = JSON.parse(response.body, symbolize_names: true)[:data]
      
      expect(data).to have_key(:url)
    end
  end
end
