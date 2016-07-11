class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    unless logged_in?
      flash[:danger] = t("user.must_login")
      redirect_to login_url
    end
  end

  def access_admin
    unless current_user.is_admin?
      flash[:danger] = t("user.access_admin")
      redirect_to root_url
    end
  end
end
