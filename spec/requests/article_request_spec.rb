require 'rails_helper'

RSpec.describe "Articles", type: :request do

  describe 'Visited by Anonymous user' do

    it "should be redirected to signin when wants to add new article" do
      get new_article_path
      expect( response ).to redirect_to( new_user_session_path )
    end

    it 'Could read an article' do
      @article = FactoryBot.create :article
      get article_path(@article)
      expect(response).to have_http_status(:success)
    end

  end

end
