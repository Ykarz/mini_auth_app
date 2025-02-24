class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  skip_before_action :current_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  # ユーザー新規登録のメソッド
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザー登録が完了しました"
      redirect_to login_path
    else
      flash.now[:danger] = "ユーザー登録に失敗しました"
      render 'new', status: :unprocessable_entity
    end
  end

  private

  # ストロングパラメータ
  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
  end
end
