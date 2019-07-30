require 'spec_helper'
require './app/models/restaurant'

RSpec.describe Restaurant do
  it 'has attributes' do
    name = "Bob's Burgers"

    address = [
      '123 Main St',
      'East Coast City, MD'
    ]

    parameters = {
      name: name,
      location: {
        display_address: address
      }
    }

    restaurant = Restaurant.new(parameters)

    expect(restaurant.name).to eq(name)
    expect(restaurant.address).to eq(address)
  end
end
