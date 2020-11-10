class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @article_latest = Article.heros.first
    @hero_article = Vote.most_voted_article
    @important_categories = Category.important_with_articles
  end
end
