require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  describe 'Visited by Anonymous user' do
    it 'should be redirected to signin when wants to add new category' do
      get new_category_path
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'GET /category show' do
      @category = FactoryBot.create :category
      get category_path(@category)
      expect(response).to have_http_status(:success)
    end

    it 'GET /categories index' do
      get categories_path
      expect(response).to have_http_status(:success)
    end

    # it 'Could sign_up GET users/sign_up' do
    #   get new_user_registration_path
    #   expect(response).to have_http_status(:success)
    # end

    # it 'Could log_in GET users/sign_in' do
    #   get new_user_session_path
    #   expect(response).to have_http_status(:success)
    # end
  end
end
