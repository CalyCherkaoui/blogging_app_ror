class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_important_categories
  before_action :authenticate_user!

  def after_sign_in_path_for(_resource)
    home_index_path
  end

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to :root, alert: 'Access denied! Please login'
  end

  private

  def set_important_categories
    @categories_important = Category.importants
  end
end
