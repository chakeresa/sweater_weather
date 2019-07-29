require 'rails_helper'

describe ApiService::Yelp do
  it 'exists' do
    expect(subject).to be_a(ApiService::Yelp)
  end

  it 'initializes with location, food_type, and epoch' do
    parameters = { 
      location: 'pueblo, co',
      food_type: 'chinese',
      epoch: 1564421959
    }
    service = ApiService::Yelp.new(parameters)
    
    expect(service.location).to eq(parameters[:location])
    expect(service.food_type).to eq(parameters[:food_type])
    expect(service.epoch).to eq(parameters[:epoch])
  end
  
  it '#restaurants returns data for many restaurants' do
    parameters = { 
      location: 'pueblo, co',
      food_type: 'chinese',
      epoch: 1564421959
    }
    service = ApiService::Yelp.new(parameters)
    result = service.restaurants
    
    expect(result[:businesses]).to be_an(Array)
    expect(result[:businesses].count).to be >= 3
    expect(result[:businesses].first).to have_key(:name)
    expect(result[:businesses].first[:location]).to have_key(:display_address)
  end
  
  it '#restaurants raises an error if the API response is bad' do
    parameters = { 
      location: 'pueblo, co',
      food_type: 'chinese',
      epoch: 1564421959
    }
    service = ApiService::Yelp.new(parameters)

    stub_const('ENV', {'YELP_API_KEY' => 'blah'})

    expect { service.restaurants }.to raise_error('Bad Yelp API key')
  end
end
