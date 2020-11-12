require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = FactoryBot.create(:user, name: 'first')
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

  context 'likes? Instance method' do
    before :each do
      @voter = FactoryBot.create(:user, name: 'voter')
      @not_voter = FactoryBot.create(:user, name: 'notvoter')
      @voted_article = FactoryBot.create(:article)
      @vote = FactoryBot.create(:vote, article_id: @voted_article.id, user_id: @voter.id)
    end

    it 'returns false when the user is not the voter of the article passed in argument' do
      expect(@not_voter.likes?(@voted_article)).to be_falsey
    end

    it 'returns true when the user is the voter of the article passed in argument' do
      expect(@voter.likes?(@voted_article)).to be_truthy
    end
  end
end
