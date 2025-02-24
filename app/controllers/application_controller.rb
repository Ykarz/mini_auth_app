class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :current_user
  before_action :require_login

  # ログインしているかどうかを確認するメソッド
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # ログインしていない場合、ログインを要求するメソッド
  def require_login
    redirect_to root_path unless current_user
  end
end
