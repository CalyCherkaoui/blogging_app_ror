require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  describe 'Visited by Anonymous user' do
    it 'GET/ Article#new: it redirects to signin' do
      get new_article_path
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'GET/ ARTICLE#show: it access to read an article' do
      @article = FactoryBot.create :article
      get article_path(@article)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Visited by signed_in user' do
    before do
      @user = FactoryBot.create(:user, name: 'logged_user')
      login_as(@user, scope: :user)
    end

    it 'GET/ Article#new: it acesses to the view' do
      get new_article_path
      expect(response).to have_http_status(:success)
    end

    it 'GET/ ARTICLE#show: it accesses to read an article' do
      @article = FactoryBot.create :article
      get article_path(@article)
      expect(response).to have_http_status(:success)
    end
  end
end
