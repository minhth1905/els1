class RelationshipsController < ApplicationController
  before_action :logged_in_user
  def index
  end

  def create
    @user = User.find_by_id params[:followed_id]
    unless @result = current_user.following?(@user)
      current_user.follow @user
    end
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @relationship = Relationship.find_by_id params[:id]
    if @relationship
      @user = @relationship.followed
      current_user.unfollow @user
    end
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end
