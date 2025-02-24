class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  skip_before_action :current_user, only: [:new, :create]
  before_action :set_user, only: [:create]

  def new; end

  # ログインメソッド
  def create
    if @user && @user.authenticate(session_params[:password])
      session[:user_id] = @user.id  # ブラウザのcookieにハッシュ化したユーザーidを保存
      flash[:success] = "ログインに成功しました"
      redirect_to user_path(@user)
    else
      flash.now[:danger] = "ログインに失敗しました"
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)  # セッションを削除
    flash[:success] = "ログアウトしました"
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find_by!(user_name: session_params[:user_name], email: session_params[:email])
  rescue
    flash.now[:danger] = "入力されたユーザーは登録されていません"
    render 'new', status: :unprocessable_entity
  end

  # ストロングパラメータ
  def session_params
    params.require(:session).permit(:user_name, :email, :password)
  end
end
