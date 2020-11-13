require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  describe 'Visited by Anonymous user' do
    it 'GET/ Homed#index: it display home page ' do
      get home_index_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Visited by signed_in user' do
    before do
      @user = FactoryBot.create(:user, name: 'logged_user')
      login_as(@user, scope: :user)
    end

    it 'GET/ Home#index: it display home page ' do
      get home_index_path
      expect(response).to have_http_status(:success)
    end
  end
end
