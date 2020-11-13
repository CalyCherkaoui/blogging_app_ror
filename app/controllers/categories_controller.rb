class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[show index]
  authorize_resource

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.paginate(page: params[:page], per_page: 6)
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @articles = @category.articles.with_attached_image.paginate(page: params[:page], per_page: 4)
  end

  # GET /categories/new
  def new
    @category = Category.new
    @categories = Category.all
  end

  # GET /categories/1/edit
  def edit
    @categories = Category.all
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to new_category_url, notice: 'Category was successfully created.' }
      else
        flash[:error] = @category.errors.full_messages.to_sentence
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to new_category_url, notice: 'Category was successfully updated.' }
      else
        flash[:error] = @category.errors.full_messages.to_sentence
        format.html { render :edit }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to new_category_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:name, :priority)
  end
end
