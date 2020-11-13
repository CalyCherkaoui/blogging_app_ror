require 'rails_helper'
# rubocop:disable Metrics/BlockLength

RSpec.feature 'VotingProcesses', type: :feature do
  before :each do
    @voter = FactoryBot.create(:user, name: 'voter_user')
    @category = FactoryBot.create(:category, name: 'category_voting')
    @author = FactoryBot.create(:user, name: 'author_author')
    @article = FactoryBot.create(:article, author_id: @author.id, category_id: @category.id)
  end

  scenario 'User non logged-in cannot like an article from article#show view' do
    visit "/articles/#{@article.id}"
    click_link('Like')
    expect(current_path).to have_content('/sign_in')
    expect(page).to have_text('You need to sign in or sign up before continuing.')
  end

  scenario 'User log-in can vote an article by linking from article#show view' do
    visit '/'
    click_link('Log-in')
    expect(current_path).to have_content('/sign_in')
    fill_in 'user_email', with: @voter.email
    fill_in 'user_password', with: @voter.password
    click_button('Log in')
    expect(current_path).to have_content('/')
    expect(page).to have_text('Signed in successfully')

    visit "/articles/#{@article.id}"
    click_link('Like')

    expect(current_path).to have_content("/articles/#{@article.id}")
    expect(page).to have_text('Dislike')
  end

  scenario 'User log-in can unvote an article he/she already liked it from article#show view' do
    visit '/'
    click_link('Log-in')
    expect(current_path).to have_content('/sign_in')
    fill_in 'user_email', with: @voter.email
    fill_in 'user_password', with: @voter.password
    click_button('Log in')
    expect(current_path).to have_content('/')
    expect(page).to have_text('Signed in successfully')

    visit "/articles/#{@article.id}"
    click_link('Like')

    expect(current_path).to have_content("/articles/#{@article.id}")
    expect(page).to have_text('Dislike')

    click_link('Dislike')
    expect(current_path).to have_content("/articles/#{@article.id}")
    expect(page).to have_text('Like')
  end

  scenario 'User non logged-in cannot like an article from category#show view' do
    visit "/categories/#{@article.category.id}"
    click_link('Like')
    expect(current_path).to have_content('/sign_in')
    expect(page).to have_text('You need to sign in or sign up before continuing.')
  end

  scenario 'User log-in can vote an article by liking it from category#show view' do
    visit '/'
    click_link('Log-in')
    expect(current_path).to have_content('/sign_in')
    fill_in 'user_email', with: @voter.email
    fill_in 'user_password', with: @voter.password
    click_button('Log in')
    expect(current_path).to have_content('/')
    expect(page).to have_text('Signed in successfully')

    visit "/categories/#{@article.category.id}"
    click_link('Like')

    expect(current_path).to have_content("/articles/#{@article.id}")
    expect(page).to have_text('Dislike')
  end

  scenario 'User log-in can unvote an article he/she already liked it from category#show view' do
    visit '/'
    click_link('Log-in')
    expect(current_path).to have_content('/sign_in')
    fill_in 'user_email', with: @voter.email
    fill_in 'user_password', with: @voter.password
    click_button('Log in')
    expect(current_path).to have_content('/')
    expect(page).to have_text('Signed in successfully')

    visit "/categories/#{@article.category.id}"
    click_link('Like')

    expect(current_path).to have_content("/articles/#{@article.id}")
    expect(page).to have_text('Dislike')

    click_link('Dislike')
    expect(current_path).to have_content("/articles/#{@article.id}")
    expect(page).to have_text('Like')
  end

  scenario 'User log-in can unvote an article he/she already liked it from his/her profile view' do
    visit '/'
    click_link('Log-in')
    expect(current_path).to have_content('/sign_in')
    fill_in 'user_email', with: @voter.email
    fill_in 'user_password', with: @voter.password
    click_button('Log in')
    expect(current_path).to have_content('/')
    expect(page).to have_text('Signed in successfully')

    visit "/categories/#{@article.category.id}"
    click_link('Like')

    expect(current_path).to have_content("/articles/#{@article.id}")
    expect(page).to have_text('Dislike')

    click_link('Profile')
    expect(current_path).to have_content("/users/#{@voter.id}")
    expect(page).to have_text(@article.title)
    expect(page).to have_text('Dislike')

    click_link('Dislike')
    expect(current_path).to have_content("/articles/#{@article.id}")
    expect(page).to have_text('Like')
  end

  scenario 'When a Loggedin User vote an article she/he expects to find it profile view in Article_I_Liked section' do
    visit '/'
    click_link('Log-in')
    expect(current_path).to have_content('/sign_in')
    fill_in 'user_email', with: @voter.email
    fill_in 'user_password', with: @voter.password
    click_button('Log in')
    expect(current_path).to have_content('/')
    expect(page).to have_text('Signed in successfully')

    visit "/articles/#{@article.id}"
    click_link('Like')

    expect(current_path).to have_content("/articles/#{@article.id}")
    expect(page).to have_text('Dislike')

    click_link('Profile')
    expect(current_path).to have_content("/users/#{@voter.id}")
    expect(page).to have_text(@article.title)
    expect(page).to have_text('Dislike')
  end

  scenario 'When a Loggedin User unvote an article, it expected to not be found in profile' do
    visit '/'
    click_link('Log-in')
    expect(current_path).to have_content('/sign_in')
    fill_in 'user_email', with: @voter.email
    fill_in 'user_password', with: @voter.password
    click_button('Log in')
    expect(current_path).to have_content('/')
    expect(page).to have_text('Signed in successfully')

    visit "/articles/#{@article.id}"
    click_link('Like')

    expect(current_path).to have_content("/articles/#{@article.id}")
    expect(page).to have_text('Dislike')

    click_link('Profile')
    expect(current_path).to have_content("/users/#{@voter.id}")
    expect(page).to have_text(@article.title)
    expect(page).to have_text('Dislike')

    click_link('Dislike')
    expect(current_path).to have_content("/articles/#{@article.id}")
    expect(page).to have_text('Like')

    click_link('Profile')
    expect(current_path).to have_content("/users/#{@voter.id}")
    expect(page).not_to have_text(@article.title)
  end
end
# rubocop:enable Metrics/BlockLength
