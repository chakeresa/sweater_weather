require 'rails_helper'

describe ApiService::Flickr do
  it 'exists' do
    expect(subject).to be_a(ApiService::Flickr)
  end

  it 'initializes with location_string' do
    location_string = 'denver, co'
    service = ApiService::Flickr.new({ location_string: location_string })
    expect(service.location_string).to eq(location_string)
  end
  
  it '#image_url returns the url for an image of the location' do
    VCR.use_cassette('api_service/flickr/image_url', record: :new_episodes) do
      location_string = 'denver, co'
      service = ApiService::Flickr.new({ location_string: location_string })
      
      expect(service.image_url).to eq('https://farm5.staticflickr.com/4325/36113488141_377936815a.jpg')
    end
  end
  
  it '#image_url raises an error if the API response is bad' do
    VCR.use_cassette('api_service/flickr/error_on_bad_api_response', record: :new_episodes) do
      service = ApiService::Flickr.new({ location_string: 'denver, co' })

      stub_const('ENV', {'FLICKR_API_KEY' => 'blah'})

      expect { service.image_url }.to raise_error('Bad Flickr API key')
    end
  end
  
  it '#image_url raises an error if the API response is empty' do
    VCR.use_cassette('api_service/flickr/error_on_empty_api_response', record: :new_episodes) do
      service = ApiService::Flickr.new({ location_string: 'asdfsdfdfsdf' })

      expect { service.image_url }.to raise_error('No images found by Flickr API')
    end
  end
end
