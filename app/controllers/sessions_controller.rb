class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: user_params[:email])&.authenticate(user_params[:password])

    if user.present?
      log_in(user)

      redirect_to root_path, notice: 'Вы вошли на сайт!'
    else
      flash.now[:alert] = 'Неправильный email или пароль'

      render :new
    end
  end

  def destroy
    session.delete(:user_id)

    redirect_to root_path, notice: 'Вы вышли из аккаунта!'
  end

  private

  def user_params
    params.require(:session)
  end
end

