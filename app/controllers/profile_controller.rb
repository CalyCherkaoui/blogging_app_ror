class ProfileController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @user = current_user
    # @liked_articles = @user.liked_articles.includes(image_attachment: :blob).includes(:category)
    @liked_articles = @user.articles.includes(image_attachment: :blob).includes(:category)
    @written_articles = @user.articles.includes(image_attachment: :blob).includes(:category)
  end
end
