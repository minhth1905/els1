class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = t("user.create_success")
      redirect_to @user
    else
      flash.now[:danger] = t("user.create_fail")
      render :new
    end
  end

  def edit
  end

  def destroy
    if @user.destroy
      flash[:success] = t("user.destroy_sucess")
    else
      flash[:danger] = t("user.destroy_fail")
    end
    redirect_to users_url
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t("user.user_edit")
      redirect_to @user
    else
      flash.now[:danger] = t("user.update_fail")
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(User::USER_ATTRIBUTES)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = t("user.must_login")
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
