class Articles::VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article

  def create
    @article.votes.where(user_id: current_user.id).first_or_create

    respond_to do |format|
      format.html { redirect_to @article }
    end
  end

  def destroy
    @article.votes.where(user_id: current_user.id).destroy_all

    respond_to do |format|
      format.html { redirect_to @article }
    end
  end

  private

    def set_article
      @article = Article.find(params[:article_id])
    end
end