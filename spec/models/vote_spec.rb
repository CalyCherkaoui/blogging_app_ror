require 'rails_helper'

RSpec.describe Vote, type: :model do
  let(:vote) { FactoryBot.create :vote }

  it 'is valid with an article and a user' do
    expect(vote).to be_valid
  end

  it 'is not valid when article is not present' do
    vote.article_id = nil
    expect(vote).to_not be_valid
  end

  it 'is not valid when user is not present' do
    vote.user_id = nil
    expect(vote).to_not be_valid
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:article) }
  end
end
