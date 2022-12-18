class UsersController < ApplicationController
  def new
    session[:current_time] = Time.now
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      log_in(@user)
      redirect_to root_path, notice: 'Вы зарегистрировались!'
    else
      flash.now[:alert] = 'Вы неправильно заполнили поля формы регистрации!'

      render :new
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])

      if @user.update(user_params)
        redirect_to root_path, notice: 'Данные пользователя обновлены!'
      else
        flash.now[:alert] = 'При попытке сохранить пользователя возникли ошибки'

        render :edit
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy

      session.delete(:user_id)
      redirect_to root_path, notice: 'Пользователь удален!'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password, :password_confirmation, :theme_color)
  end
end
