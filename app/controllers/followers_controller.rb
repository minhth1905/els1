class FollowersController < ApplicationController
  before_action :set_user

  def index
    @users = @user.followers.paginate page: params[:page],
      per_page: Settings.users_per_page
  end
end
