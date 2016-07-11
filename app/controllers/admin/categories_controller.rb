class Admin::CategoriesController < ApplicationController
  before_action :access_admin, :logged_in_user
  before_action :find_category_by_id, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = t("categories.success_create")
      redirect_to admin_categories_url
    else
      flash.now[:danger] = t("categories.fail_create")
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes(category_params)
      flash[:success] = t("categories.success_update")
      redirect_to admin_categories_url
    else
      flash.now[:danger] = t("categories.fail_update")
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t("categories.success_delete")
    else
      flash[:danger] = t("categories.fail_delete")
    end
    redirect_to admin_categories_url
  end

  private
  def category_params
    params.require(:category).permit(:title , :description)
  end

  def find_category_by_id
    @category = Category.find_by(id: params[:id])
  end
end
