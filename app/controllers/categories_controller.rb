class CategoriesController < ApplicationController
  before_action :find_category_by_id, only: :show

  def index
    @categories = Category.all
  end

  def show
    @words = @category.words.paginate(page: params[:page])
  end

  private
  def find_category_by_id
    @category = Category.find(params[:id])
  end
end
