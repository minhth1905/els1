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

  def show
    @word = Word.find(params[:id])
  end

  def new
    @word = Word.new
    4.times do
      @word.answers.build
    end
  end

  def create
    @word = Word.new(word_params)
    if @word.save
      flash[:success] = t("words.create_success")
      redirect_to @word
    else
      flash.now[:danger] = t("words.create_fail")
      render :new
    end
  end

  private
  def word_params
    params.require(:word).permit :national, :category_id,
      answers_attributes: [:id, :meaning, :status, :_destroy]
  end
end
