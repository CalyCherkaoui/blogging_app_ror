class DashboardController < ApplicationController
  def index
    authorize! :manage, :dashboard
    @articles_num = Article.count
    @likes = Vote.count
    @categories_num = Category.count
    @articles_released = Article.released_with_attachements
    @latest_added_article = Article.heros.first
    @most_voted_article = Vote.most_voted_article
    @latest_added_category = Category.last
  end
end
