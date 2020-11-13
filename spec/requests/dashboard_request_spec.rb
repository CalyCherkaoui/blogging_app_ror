require 'rails_helper'

RSpec.describe 'Dashboards', type: :request do
  describe 'Visited by Anonymous user' do
    it 'GET/ Dashboard#index: it redirects to signin ' do
      get dashboard_index_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'Visited by signed_in user with user_role abilities' do
    before do
      @user = FactoryBot.create(:user, name: 'logged_user')
      login_as(@user, scope: :user)
    end

    it 'GET/ Dashboard#index: it redirects to root with flash message ' do
      get dashboard_index_path
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'Visited by signed_in user with moderator_role abilities' do
    before do
      @moderator = FactoryBot.create(:user,
                                     name: 'logged_moderator',
                                     moderator_role: true,
                                     user_role: false)
      login_as(@moderator, scope: :user)
    end

    it 'GET/ Dashboard#index: it it accesses to the dashboard' do
      get dashboard_index_path
      expect(response).to have_http_status(:success)
    end
  end
end
