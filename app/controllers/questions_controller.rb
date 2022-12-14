class QuestionsController < ApplicationController
  before_action :ensure_current_user, only: %i[update destroy edit hide]
  before_action :set_question_for_current_user, only: %i[update destroy edit hide]

  def new
    @user = User.find_by!(nickname: params[:nickname])
    @question = Question.new(user: @user)
  end

  def create
    question_params = params.require(:question).permit(:body, :user_id)
    @question = Question.new(question_params)
    @question.author = current_user

    if @question.save
      redirect_to user_path(@question.user), notice: 'Новый вопрос создан!'
    else
      flash[:alert] = 'Вы неправильно заполнили вопрос!'

      redirect_to user_path(@question.user)
    end
  end

  def update
    question_params = params.require(:question).permit(:body, :answer)
    if @question.update(question_params)
      redirect_to user_path(@question.user), notice: 'Cохранили вопрос!'
    else
      flash.now[:alert] = 'Вы неправильно заполнили вопрос!'

      render :edit
    end
  end

  def destroy
    @user = @question.user
    @question.destroy

    redirect_to user_path(@user), notice: 'Вопрос удален!'
  end

  def show
    @question = Question.find(params[:id])
  end

  def index
    @questions = Question.order(created_at: :desc).first(10)
    @users = User.order(created_at: :desc).first(10)
    @tags = Tag.order(created_at: :desc).first(10)
  end

  def edit; end

  def hide
    @user = @question.user
    @question.toggle(:hidden).save

    redirect_to user_path(@user)
  end

  private

  def ensure_current_user
    redirect_with_alert unless current_user.present?
  end

  def set_question_for_current_user
    @question = current_user.questions.find(params[:id])
  end
end
