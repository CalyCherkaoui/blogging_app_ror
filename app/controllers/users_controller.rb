class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end
end