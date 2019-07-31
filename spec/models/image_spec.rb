require 'rails_helper'

RSpec.describe Image, type: :model do
  describe 'validations' do
    it { should validate_uniqueness_of(:title).case_insensitive }
    it { should validate_presence_of :title }
  end
  
  it 'automatically makes titles lowercase' do
    title = 'Denver, CO'
    image = create(:image, title: title)
  
    expect(image.title).to eq(title.downcase)
  end
end
