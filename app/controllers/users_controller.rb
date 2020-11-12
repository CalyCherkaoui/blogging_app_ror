class UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @liked_articles = @user.liked_articles.includes(image_attachment: :blob).includes(:category)
    @written_articles = @user.articles.includes(image_attachment: :blob).includes(:category)
  end
end
