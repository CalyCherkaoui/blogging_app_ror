require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'associations' do
    it { should belong_to(:author) }
    it { should belong_to(:category) }
    it { should have_many(:votes) }
  end

  describe 'Title validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_least(6) }
    it { should validate_length_of(:title).is_at_most(80) }
  end

  describe 'Text validation' do
    it { should validate_presence_of(:text) }
    it { should validate_length_of(:text).is_at_least(10) }
  end

  describe 'Category_id validation' do
    it { should validate_presence_of(:category_id) }
  end
end
