require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of :email }
  end

  it 'automatically adds a random api_key' do
    user1 = create(:user)
    user2 = create(:user)

    expect(user1.api_key).to_not be_nil
    expect(user1.api_key).to_not eq(user2.api_key)
  end
  
  it 'automatically makes emails lowercase' do
    email = "HelloBob"
    user = create(:user, email: email)
  
    expect(user.email).to eq(email.downcase)
  end
end
