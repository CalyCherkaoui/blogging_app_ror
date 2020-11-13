require 'rails_helper'
# rubocop:disable Metrics/BlockLength

RSpec.feature 'Profiles', type: :feature do
  before :each do
    @profile = FactoryBot.create(:user, name: 'profile_user')
    @visitor = FactoryBot.create(:user, name: 'visitor_user')
    @author = FactoryBot.create(:user, name: 'author_user')
    @category = FactoryBot.create(:category, name: 'category_profile')
    @article = FactoryBot.create(:article, author_id: @author.id, category_id: @category.id)
  end

  scenario 'Anonymous visotor can read an author profile, cannot see Author liked articles' do
    visit "/articles/#{@article.id}"
    click_link(@article.author.name.to_s)
    expect(current_path).to have_content("/users/#{@article.author.id}")
    expect(page).to have_text('Articles I Wrote')
    expect(page).not_to have_text('Articles I liked')
  end

  scenario 'Visitor log-in, visit author profile, cannot see Author liked articles' do
    visit '/'
    click_link('Log-in')
    expect(current_path).to have_content('/sign_in')
    fill_in 'user_email', with: @visitor.email
    fill_in 'user_password', with: @visitor.password
    click_button('Log in')
    expect(current_path).to have_content('/')
    expect(page).to have_text('Signed in successfully')

    visit "/articles/#{@article.id}"
    click_link(@article.author.name.to_s)
    expect(current_path).to have_content("/users/#{@article.author.id}")
    expect(page).to have_text('Articles I Wrote')
    expect(page).not_to have_text('Articles I liked')
  end

  scenario 'Author log-in, visit her/his profile, can see liked & written articles' do
    visit '/'
    click_link('Log-in')
    expect(current_path).to have_content('/sign_in')
    fill_in 'user_email', with: @author.email
    fill_in 'user_password', with: @author.password
    click_button('Log in')
    expect(current_path).to have_content('/')
    expect(page).to have_text('Signed in successfully')

    click_link('Profile')
    expect(current_path).to have_content("/users/#{@author.id}")
    expect(page).to have_text('Articles I Wrote')
    expect(page).to have_text('Articles I liked')
  end
end
# rubocop:enable Metrics/BlockLength
