class CategoriesController < ApplicationController
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
      redirect_to @category
    else
      flash.now[:danger] = t("categories.fail_create")
      render "new"
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:success] = t("categories.success_update")
      redirect_to @category
    else
      flash.now[:danger] = t("categories.fail_update")
      render "edit"
    end
  end

  private
  def category_params
    params.require(:category).permit(:title , :description)
  end
end
