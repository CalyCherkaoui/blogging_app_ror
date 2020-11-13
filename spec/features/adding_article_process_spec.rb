require 'rails_helper'
# rubocop:disable Metrics/BlockLength

RSpec.feature 'AddingArticleProcesses', type: :feature do
  before :each do
    @user = FactoryBot.create(:user, name: 'author_user')
    @category = FactoryBot.create(:category, name: 'add_article')
    @author = FactoryBot.create(:user, name: 'author_author')
    @article = FactoryBot.create(:article,
                                 author_id: @author.id,
                                 category_id: @category.id)
    @moderator = FactoryBot.create(:user,
                                   name: 'moderator_edit_art',
                                   moderator_role: true,
                                   user_role: false)
  end

  scenario 'User log-in as user and add an article and edit it' do
    visit '/'
    click_link('Log-in')
    expect(current_path).to have_content('/sign_in')
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button('Log in')

    expect(current_path).to have_content('/')
    expect(page).to have_text('Signed in successfully')
    click_link('add-article')

    expect(current_path).to have_content('/articles/new')
    fill_in('article[title]', with: 'THIS IS A TEST')
    fill_in('article[text]', with: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')
    attach_file('article[image]', './spec/doc/test.jpg')
    within 'select#article_category_id' do
      find("option[value='#{@category.id}']").click
    end
    click_button('Create Article')

    expect(current_path).to have_content('/articles/')
    expect(page).to have_text('Article was successfully created.')
    click_link('Edit this article')

    expect(current_path).to have_content('/edit')
    fill_in('article[title]', with: 'Edited Test title')
    click_button('Update Article')
    expect(current_path).to have_content('/articles/')
    expect(page).to have_text('Article was successfully updated.')
    expect(page).to have_text('Edited Test title')
  end

  scenario 'User log-in as user cannot edit an article of an other author' do
    visit '/'
    click_link('Log-in')
    expect(current_path).to have_content('/sign_in')
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button('Log in')

    expect(current_path).to have_content('/')
    expect(page).to have_text('Signed in successfully')

    visit "/articles/#{@article.id}/edit"
    expect(current_path).to have_content('/')
    expect(page).to have_text('Access denied! Please login')
  end

  scenario 'User log-in as Moderator can edit an article of an other author' do
    visit '/'
    click_link('Log-in')
    expect(current_path).to have_content('/sign_in')
    fill_in 'user_email', with: @moderator.email
    fill_in 'user_password', with: @moderator.password
    click_button('Log in')

    expect(current_path).to have_content('/')
    expect(page).to have_text('Signed in successfully')

    visit "/articles/#{@article.id}/edit"
    fill_in 'article[title]', with: 'Edited title by moderator'
    click_button('Update Article')

    expect(current_path).to have_content('/articles/')
    expect(page).to have_text('Article was successfully updated.')
    expect(page).to have_text('Edited title by moderator')
  end
end
# rubocop:enable Metrics/BlockLength
