class CategoriesController < ApplicationController
  before_action :find_category_by_id, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = t("categories.success_create")
      redirect_to @category
    else
      flash.now[:danger] = t("categories.fail_create")
      render "new"
    end
  end

  def edit
  end

  def update
    if @category.update_attributes(category_params)
      flash[:success] = t("categories.success_update")
      redirect_to @category
    else
      flash.now[:danger] = t("categories.fail_update")
      render "edit"
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t("categories.success_delete")
    else
      flash[:danger] = t("categories.fail_delete")
    end
    redirect_to categories_url
  end

  private
  def category_params
    params.require(:category).permit(:title , :description)
  end

  def find_category_by_id
    @category = Category.find(params[:id])
  end
end
