class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: [:show]
  authorize_resource

  # GET /articles
  # GET /articles.json

  # GET /articles/1
  # GET /articles/1.json
  def show; end

  # GET /articles/new
  def new
    @article = Article.new
    @categories = Category.all
  end

  # GET /articles/1/edit
  def edit
    @categories = Category.all
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.author = current_user

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
      else
        flash[:error] = @article.errors.full_messages.to_sentence
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
      else
        flash[:error] = @article.errors.full_messages.to_sentence
        format.html { render :edit }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :text, :draft, :category_id, :image)
  end
end
