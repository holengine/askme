class QuestionsController < ApplicationController
  before_action :set_question, only: %i[update show destroy edit hide]
  def create
    @question = Question.create(question_params)

    if @question.save
      redirect_to question_path(@question), notice: 'Новый вопрос создан!'
    else
      flash.now[:alert] = 'Вы неправильно заполнили вопрос!'

      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to question_path(@question), notice: 'Cохранили вопрос!'
    else
      flash.now[:alert] = 'Вы неправильно заполнили вопрос!'

      render :edit
    end
  end

  def destroy
    @question.destroy

    redirect_to questions_path, notice: 'Вопрос удален!'
  end

  def show; end

  def index
    @question = Question.new
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def edit; end

  def hide
    @question.toggle(:hidden).save

    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:body, :user_id, :hidden)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
