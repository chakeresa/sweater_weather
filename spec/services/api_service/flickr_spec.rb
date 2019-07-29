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
    location_string = 'denver, co'
    service = ApiService::Flickr.new({ location_string: location_string })
    
    expect(service.image_url).to eq('https://farm8.staticflickr.com/7314/16262388280_dd4edfa9a4.jpg')
  end
  
  it '#image_url raises an error if the API response is bad' do
    service = ApiService::Flickr.new({ location_string: 'denver, co' })

    stub_const('ENV', {'FLICKR_API_KEY' => 'blah'})

    expect { service.image_url }.to raise_error('Bad Flickr API key')
  end
end
