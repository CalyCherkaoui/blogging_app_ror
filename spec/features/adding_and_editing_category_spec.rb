require 'rails_helper'
# rubocop:disable Metrics/BlockLength

RSpec.feature 'AddingAndEditingCategories', type: :feature do
  before :each do
    @user = FactoryBot.create(:user, name: 'author_user')
    @category = FactoryBot.create(:category, name: 'add_category')
    @author = FactoryBot.create(:user, name: 'author_author')
    @article = FactoryBot.create(:article, author_id: @author.id)
    @moderator = FactoryBot.create(:user,
                                   name: 'moderator_category',
                                   moderator_role: true,
                                   user_role: false)
  end

  scenario 'User log-in as user cannot add a new category' do
    visit '/'
    click_link('Log-in')
    expect(current_path).to have_content('/sign_in')
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button('Log in')
    expect(current_path).to have_content('/')
    expect(page).to have_text('Signed in successfully')

    visit '/categories/new'
    expect(current_path).to have_content('/')
    expect(page).to have_text('Access denied! Please login')
  end

  scenario 'User log-in as user cannot edit an existing category' do
    visit '/'
    click_link('Log-in')
    expect(current_path).to have_content('/sign_in')
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button('Log in')

    expect(current_path).to have_content('/')
    expect(page).to have_text('Signed in successfully')

    visit "/categories/#{@category.id}/edit"
    expect(current_path).to have_content('/')
    expect(page).to have_text('Access denied! Please login')
  end

  scenario 'User log-in as Moderator can add new category' do
    visit '/'
    click_link('Log-in')
    expect(current_path).to have_content('/sign_in')
    fill_in 'user_email', with: @moderator.email
    fill_in 'user_password', with: @moderator.password
    click_button('Log in')

    expect(current_path).to have_content('/')
    expect(page).to have_text('Signed in successfully')

    visit '/categories/new'
    fill_in('category[name]', with: 'added_by_moderator')
    fill_in('category[priority]', with: '10')
    click_button('Create Category')

    expect(current_path).to have_content('/categories/new')
    expect(page).to have_text('Category was successfully created.')
    expect(page).to have_text('added_by_moderator')
  end

  scenario 'User log-in as Moderator can add edit an existing category' do
    visit '/'
    click_link('Log-in')
    expect(current_path).to have_content('/sign_in')
    fill_in 'user_email', with: @moderator.email
    fill_in 'user_password', with: @moderator.password
    click_button('Log in')

    expect(current_path).to have_content('/')
    expect(page).to have_text('Signed in successfully')

    visit "/categories/#{@category.id}/edit"
    fill_in('category[name]', with: 'Edited_by_moderator')
    fill_in('category[priority]', with: '11')
    click_button('Update Category')

    expect(current_path).to have_content('/categories/new')
    expect(page).to have_text('Category was successfully updated.')
    expect(page).to have_text('Edited_by_moderator')
  end
end
# rubocop:enable Metrics/BlockLength
