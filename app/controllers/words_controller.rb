class WordsController < ApplicationController
  before_action :find_word, except: [:new, :index, :create]

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
  end

  def new
    @word = Word.new
    Settings.number_answers.times do
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

  def edit
  end

  def update
    if @word.update_attributes(word_params)
      flash[:success] = t("words.success_update")
      redirect_to @word
    else
      flash.now[:danger] = t("words.fail_update")
      render :edit
    end
  end

  def destroy
    if @word.destroy
      flash[:success] = t("words.success_delete")
    else
      flash[:danger] = t("words.fail_delete")
    end
    redirect_to words_url
  end

  private
  def word_params
    params.require(:word).permit :national, :category_id,
      answers_attributes: [:id, :meaning, :status, :_destroy]
  end

  def find_word
    @word = Word.find(params[:id])
  end
end
