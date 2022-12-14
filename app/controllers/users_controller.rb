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
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password)
  end
end
