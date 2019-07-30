class Restaurant
  attr_reader :name, :address
  
  def initialize(restaurant_hash)
    @name = restaurant_hash[:name]
    @address = restaurant_hash[:location][:display_address]
  end
end
