require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.create(
      email: 'test@foobar.com',
      password: 'password123',
      password_confirmation: 'password123',
      name: 'test'
    )
  end

  it 'is valid with a name, an email and a password & confirmation' do
    expect(@user).to be_valid
  end

  it 'is authenticable with valid password confirmation' do
    expect(@user.valid_password?('password123')).to be_truthy
  end

  describe 'Associations' do
    it { should have_many(:articles) }
  end

  describe 'Name validations' do
    it { should validate_presence_of(:name) }
  end
end
