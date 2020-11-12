# rubocop:disable Style/MixinUsage

include ActionDispatch::TestProcess

FactoryBot.define do
  factory :user do
    password { 'password123' }
    password_confirmation { 'password123' }
    name { 'factoryboy' }
    # sequence(:name, 5) { |n| "person#{n}" }
    email { "#{name}@foobar.com".downcase }
  end

  factory :category do
    name { 'categorytest' }
    priority { 1 }
  end

  factory :article do
    association :author, factory: :user, name: 'author1'
    title { 'ABCDEFG' }
    text { 'IJKLMNOPQRSTUVWXYZ' }
    association :category, factory: :category
    image { fixture_file_upload(Rails.root.join('spec', 'doc', 'test.jpg'), 'image/jpg') }
  end

  factory :vote do
    user_id { create(:user).id }
    article_id { create(:article).id }
  end
end

# rubocop:enable Style/MixinUsage;
