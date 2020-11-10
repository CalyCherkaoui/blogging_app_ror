class Articles::VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article

  def create
    current_user.like_article(@article)

    respond_to do |format|
      format.html { redirect_to @article }
    end
  end

  def destroy
    current_user.dislike_article(@article)

    respond_to do |format|
      format.html { redirect_to @article }
    end
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end
end
