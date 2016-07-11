class Admin::UsersController < ApplicationController
  before_action :access_admin, :logged_in_user
  before_action :set_user, only: :destroy

  def index
    @users = User.paginate page: params[:page],
      per_page: Settings.users_per_page
  end

  def destroy
    if @user.destroy
      flash[:success] = t("user.destroy_success")
    else
      flash[:danger] = t("user.destroy_fail")
    end
    redirect_to admin_users_path
  end

  private
  def set_user
    @user = User.find_by(id: params[:id])
  end
end
