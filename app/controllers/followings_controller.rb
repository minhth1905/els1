class FollowingsController < ApplicationController
  before_action :set_user

  def index
    @users = @user.following.paginate page: params[:page],
      per_page: Settings.users_per_page
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
