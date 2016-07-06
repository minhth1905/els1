class WordsController < ApplicationController
  def index
    @categories = Category.all
    if params[:category] && params[:learn]
      category = Category.find_by(id: params[:category])
      if params[:learn] == "all"
        @words = category.words
      elsif params[:learn] == "learned"
        @words = category.words.learned(current_user.id)
      else
        @words = category.words.notlearned(current_user.id)
      end
    end
  end
end
