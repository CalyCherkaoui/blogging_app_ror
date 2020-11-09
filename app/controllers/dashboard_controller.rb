class DashboardController < ApplicationController
  def index
    authorize! :manage, :dashboard
  end
end
